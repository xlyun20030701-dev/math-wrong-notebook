// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:smart_wrong_notebook/src/mistake/ai/ai_chat_client.dart';
import 'package:smart_wrong_notebook/src/mistake/ai/ai_models.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';
import 'package:smart_wrong_notebook/src/mistake/screens/block_select_screen.dart';

/// AI 整页题目区域候选：AI只给候选框；用户勾选/删除，再加入已有错题或新建错题。
class PageAiSelectScreen extends ConsumerStatefulWidget {
  const PageAiSelectScreen({
    required this.pageId,
    required this.paperId,
    super.key,
  });

  final int pageId;
  final int paperId;

  @override
  ConsumerState<PageAiSelectScreen> createState() =>
      _PageAiSelectScreenState();
}

class _Candidate {
  _Candidate(this.region, this.accepted);
  final AiPageRegion region;
  bool accepted;
}

class _PageAiSelectScreenState extends ConsumerState<PageAiSelectScreen> {
  bool _loading = false;
  List<_Candidate>? _candidates;
  img.Image? _baked;

  @override
  Widget build(BuildContext context) {
    final page = ref.watch(pageByIdProvider(widget.pageId)).value;
    if (page == null) {
      return const Scaffold(body: Center(child: Text('页面不存在')));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI 检测题目区域'),
        actions: <Widget>[
          TextButton(
            onPressed: _loading ? null : () => _detect(page),
            child: const Text('重新检测'),
          ),
        ],
      ),
      body: _candidates == null
          ? Center(
              child: _loading
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('AI 将识别页面中的题目区域（仅候选，不会自动建题）'),
                        const SizedBox(height: 12),
                        FilledButton.icon(
                          onPressed: () => _detect(page),
                          icon: const Icon(CupertinoIcons.sparkles),
                          label: const Text('开始检测'),
                        ),
                      ],
                    ),
            )
          : Column(
              children: <Widget>[
                _pagePreview(page),
                const Divider(height: 1),
                Expanded(
                  child: _candidateList(),
                ),
              ],
            ),
    );
  }

  Widget _pagePreview(PageRecord page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final aspect = _aspect(page);
        final areaW = math.max(160.0, constraints.maxWidth - 16);
        final fitW = areaW;
        final fitH = fitW / aspect;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            width: fitW,
            height: math.min(fitH, constraints.maxHeight * 0.6),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.file(File(page.originalImagePath),
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(CupertinoIcons.photo)),
                if (_candidates != null)
                  CustomPaint(
                    painter: _CandidatePainter(
                      candidates: _candidates!
                          .where((c) => c.accepted)
                          .map((c) => c.region)
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  double _aspect(PageRecord page) {
    final w = page.width;
    final h = page.height;
    return (w != null && h != null && w > 0 && h > 0) ? w / h : 0.75;
  }

  Widget _candidateList() {
    final list = _candidates!;
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: list.length,
      itemBuilder: (context, i) {
        final c = list[i];
        final label = c.region.label ?? '题 ${c.region.order}';
        final suspect = label.contains('疑似');
        return Card(
          child: ListTile(
            dense: true,
            leading: Checkbox(
              value: c.accepted,
              onChanged: (v) => setState(() => c.accepted = v ?? false),
            ),
            title: Text(suspect ? '$label（疑似错题）' : label),
            subtitle: Text('x=${c.region.x.toStringAsFixed(2)} … '
                '(${c.region.width.toStringAsFixed(2)}×${c.region.height.toStringAsFixed(2)})'),
            trailing: IconButton(
              icon: const Icon(CupertinoIcons.trash),
              onPressed: () => setState(() => list.removeAt(i)),
            ),
            onTap: () => _saveCandidate(c.region, label),
          ),
        );
      },
    );
  }

  Future<void> _detect(PageRecord page) async {
    setState(() => _loading = true);
    try {
      final regions = await ref.read(aiActionsProvider).detectPageRegions(page.id);
      if (!mounted) return;
      setState(() {
        _candidates = regions.map((r) => _Candidate(r, true)).toList();
      });
    } on AiApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('检测失败：$e')));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _saveCandidate(AiPageRegion region, String label) async {
    final number = (label.replaceAll('疑似', '')).trim();
    final basket = ref
            .read(watchQuestionsOfPaperProvider(widget.paperId))
            .value ??
        const <Question>[];
    final picked = await showModalBottomSheet<BlockTargetSelection>(
      context: context,
      isScrollControlled: true,
      builder: (_) => NewBlockTargetSheet(
        blockType: 'stem',
        basket: basket,
        blockCounts: const <int, int>{},
      ),
    );
    if (picked == null || !mounted) return;
    final db = ref.read(mistakeDbProvider);
    final store = ref.read(mistakeImageStoreProvider);
    final page = await db.pageById(widget.pageId);
    if (page == null) return;
    try {
      int qid;
      if (picked.isNew) {
        final q = picked.newQuestion!;
        final numText = (q.number?.isNotEmpty ?? false)
            ? q.number
            : (number.isEmpty ? null : number);
        qid = await db.insertQuestion(
          paperId: widget.paperId,
          originalQuestionNumber: numText,
          title: q.title,
        );
      } else {
        qid = picked.existingQuestionId!;
      }
      _baked ??= await store.decodeBaked(page.originalImagePath);
      final crop = await store.cropBaked(
        widget.paperId,
        _baked!,
        x: region.x,
        y: region.y,
        width: region.width,
        height: region.height,
      );
      final order = await db.nextSortOrder(qid);
      await db.insertBlock(
        questionId: qid,
        pageId: widget.pageId,
        blockType: picked.blockType,
        x: region.x,
        y: region.y,
        width: region.width,
        height: region.height,
        sortOrder: order,
        processedImagePath: crop,
        processingStatus: 'cropped',
      );
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('已加入错题')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('保存失败：$e')));
      }
    }
  }
}

class _CandidatePainter extends CustomPainter {
  _CandidatePainter({required this.candidates});
  final List<AiPageRegion> candidates;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.orange;
    for (final r in candidates) {
      canvas.drawRect(
        Rect.fromLTWH(r.x * size.width, r.y * size.height,
            r.width * size.width, r.height * size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CandidatePainter old) => true;
}
