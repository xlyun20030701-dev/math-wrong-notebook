// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/print/layout_engine.dart';
import 'package:smart_wrong_notebook/src/mistake/print/pdf_print_service.dart';
import 'package:smart_wrong_notebook/src/mistake/print/print_loader.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';
import 'package:smart_wrong_notebook/src/mistake/widgets/a4_preview.dart';

/// 打印列表 + 模式/答题空间调节 + 预览 + PDF/系统打印。
class PrintListScreen extends ConsumerStatefulWidget {
  const PrintListScreen({super.key});

  @override
  ConsumerState<PrintListScreen> createState() => _PrintListScreenState();
}

class _PrintListScreenState extends ConsumerState<PrintListScreen> {
  PrintMode _mode = PrintMode.exam;
  bool _cutLines = false;
  final bool _showAnswers = false;
  int _globalSpace = 40;
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(watchPrintItemsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('打印'),
        actions: <Widget>[
          IconButton(
            tooltip: '预览',
            onPressed: _busy ? null : () => _preview(context),
            icon: const Icon(CupertinoIcons.eye),
          ),
          IconButton(
            tooltip: '导出 PDF 并分享',
            onPressed: _busy ? null : () => _export(context),
            icon: const Icon(CupertinoIcons.share),
          ),
          IconButton(
            tooltip: '系统打印',
            onPressed: _busy ? null : () => _systemPrint(context),
            icon: const Icon(CupertinoIcons.printer),
          ),
        ],
      ),
      body: items.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('加载失败：$e')),
        data: (list) {
          if (list.isEmpty) {
            return const Center(
                child: Text('打印列表为空\n在错题/题目详情里点“加入打印”'));
          }
          return Column(
            children: <Widget>[
              _buildControls(list),
              Expanded(
                child: ReorderableListView.builder(
                  itemCount: list.length,
                  onReorderItem: (a, b) async {
                    final ids = List<int>.of(list.map((x) => x.id));
                    final v = ids.removeAt(a);
                    ids.insert(b, v);
                    await ref.read(mistakeDbProvider).reorderPrintItems(ids);
                  },
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return ListTile(
                      key: ValueKey<int>(item.id),
                      leading: ReorderableDragStartListener(
                        index: index,
                        child: const Icon(CupertinoIcons.bars),
                      ),
                      title: Text(_label(list, index),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text('答题空间 ${item.answerSpaceMm}mm'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            tooltip: '-10mm',
                            icon: const Icon(CupertinoIcons.minus),
                            onPressed: () => _adjustSpace(item, -10),
                          ),
                          IconButton(
                            tooltip: '+10mm',
                            icon: const Icon(CupertinoIcons.plus),
                            onPressed: () => _adjustSpace(item, 10),
                          ),
                          IconButton(
                            tooltip: '移除',
                            icon: const Icon(CupertinoIcons.trash),
                            onPressed: () async {
                              await ref
                                  .read(mistakeDbProvider)
                                  .deletePrintItem(item.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _label(List<PrintItem> list, int index) {
    final q = list[index];
    return q.kind == 'exercise' ? '举一反三题 #${q.id}' : '错题 #${q.id}';
  }

  Widget _buildControls(List<PrintItem> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SegmentedButton<PrintMode>(
                showSelectedIcon: false,
                segments: const <ButtonSegment<PrintMode>>[
                  ButtonSegment<PrintMode>(
                    value: PrintMode.cutAndPaste,
                    label: Text('剪贴'),
                  ),
                  ButtonSegment<PrintMode>(
                    value: PrintMode.exam,
                    label: Text('复习卷'),
                  ),
                ],
                selected: <PrintMode>{_mode},
                onSelectionChanged: (s) => setState(() => _mode = s.first),
              ),
              const Spacer(),
              Switch(
                value: _cutLines,
                onChanged: (v) => setState(() => _cutLines = v),
              ),
              const Text('裁切线'),
            ],
          ),
          Row(
            children: <Widget>[
              const Text('全局答题空间'),
              Expanded(
                child: Slider(
                  value: _globalSpace.toDouble(),
                  min: 0,
                  max: 80,
                  divisions: 8,
                  label: '$_globalSpace mm',
                  onChanged: (v) =>
                      setState(() => _globalSpace = v.round()),
                  onChangeEnd: (v) => _applyGlobal(list, v.round()),
                ),
              ),
              Text('$_globalSpace mm'),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _adjustSpace(PrintItem item, int delta) async {
    final next = (item.answerSpaceMm + delta).clamp(0, 80);
    await ref
        .read(mistakeDbProvider)
        .updatePrintItem(item.id,
            PrintItemsCompanion(answerSpaceMm: Value(next)));
  }

  Future<void> _applyGlobal(List<PrintItem> list, int mm) async {
    final db = ref.read(mistakeDbProvider);
    for (final item in list) {
      await db.updatePrintItem(
          item.id, PrintItemsCompanion(answerSpaceMm: Value(mm)));
    }
  }

  Future<(List<A4PageLayout>, LayoutOptions)> _build() async {
    final db = ref.read(mistakeDbProvider);
    final cleaning = ref.read(cleaningServiceProvider);
    final docs = await loadPrintDocs(db, cleaning, includeAnswers: _showAnswers);
    final opts = LayoutOptions(
      mode: _mode,
      cutLines: _cutLines,
    );
    final pages = const PrintLayoutEngine().layout(
        questions: docs, options: opts);
    return (pages, opts);
  }

  Future<void> _preview(BuildContext context) async {
    final (pages, opts) = await _build();
    if (!context.mounted) return;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('A4 预览（共 ${pages.length} 页）',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(child: A4Preview(pages: pages, options: opts)),
          ],
        ),
      ),
    );
  }

  Future<void> _export(BuildContext context) async {
    setState(() => _busy = true);
    try {
      final built = await _build();
      final pdf = await ref.read(pdfPrintServiceProvider).build(
            pages: built.$1,
            options: built.$2, font: await loadDeviceCjkFont(),
          );
      if (!mounted) return;
      final tmp = File(
          '${Directory.systemTemp.path}/print_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await tmp.writeAsBytes(pdf, flush: true);
      await Share.shareXFiles(<XFile>[
        XFile(tmp.path, mimeType: 'application/pdf'),
      ]);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('导出失败：$e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _systemPrint(BuildContext context) async {
    setState(() => _busy = true);
    try {
      final built = await _build();
      final pdf = await ref
          .read(pdfPrintServiceProvider)
          .build(pages: built.$1, options: built.$2);
      await Printing.layoutPdf(
        onLayout: (format) async => pdf,
        name: 'wrong_notebook',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('打印失败：$e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}


