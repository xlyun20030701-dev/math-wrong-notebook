// ignore_for_file: use_build_context_synchronously
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smart_wrong_notebook/src/mistake/ai/ai_chat_client.dart';
import 'package:smart_wrong_notebook/src/mistake/backup/backup_service.dart';
import 'package:smart_wrong_notebook/src/mistake/providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final TextEditingController _key = TextEditingController();
  final TextEditingController _model = TextEditingController();
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final store = ref.read(aiSettingsStoreProvider);
    final key = await store.apiKey();
    final model = await store.model();
    if (!mounted) return;
    setState(() {
      _model.text = model;
    });
    if (key != null && key.isNotEmpty) {
      _key.text = ''; // 不显示真实 Key
      _hasKey = true;
    }
  }

  bool _hasKey = false;

  @override
  void dispose() {
    _key.dispose();
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const Text('AI 设置', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _key,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: _hasKey ? 'OpenAI API Key（已保存）' : 'OpenAI API Key',
              hintText: '仅保存在本机安全存储',
              helperText: '不会写入源码/日志，也不会随备份导出',
            ),
          ),
          TextField(
            controller: _model,
            decoration: const InputDecoration(
                labelText: '模型（视觉模型，如 gpt-4o / gpt-4o-mini）'),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              FilledButton.icon(
                onPressed: _busy ? null : _saveKey,
                icon: const Icon(CupertinoIcons.lock),
                label: const Text('保存'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: _busy ? null : _testConnection,
                icon: const Icon(CupertinoIcons.check_mark_circled),
                label: const Text('测试连接'),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () async {
                  await ref.read(aiSettingsStoreProvider).deleteApiKey();
                  if (!mounted) return;
                  setState(() => _hasKey = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('已删除 API Key')),
                  );
                },
                child: const Text('删除'),
              ),
            ],
          ),
          const Divider(height: 32),
          const Text('备份与恢复', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              OutlinedButton.icon(
                onPressed: _busy ? null : _exportBackup,
                icon: const Icon(CupertinoIcons.download_circle),
                label: const Text('导出 ZIP 备份'),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: _busy ? null : _restoreBackup,
                icon: const Icon(CupertinoIcons.upload_circle),
                label: const Text('恢复备份'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('说明：备份包含数据库与全部图片/处理结果。恢复需先通过校验，重启应用后生效。',
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Future<void> _saveKey() async {
    setState(() => _busy = true);
    try {
      final store = ref.read(aiSettingsStoreProvider);
      final key = _key.text.trim();
      await store.saveApiKey(key);
      final model = _model.text.trim();
      if (model.isNotEmpty) await store.saveModel(model);
      if (!mounted) return;
      setState(() => _hasKey = key.isNotEmpty);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(key.isEmpty ? '已清除' : '已保存')),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _testConnection() async {
    setState(() => _busy = true);
    try {
      final client = ref.read(aiChatClientProvider);
      final text = await client.chat(
        system: '只回复 OK',
        user: 'ping',
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text.contains('OK') ? '连接成功' : '连接成功：$text')),
      );
    } on AiApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<BackupService> _service() async {
    final docs = await getApplicationDocumentsDirectory();
    final root = p.join(docs.path, 'math_wrong_notebook');
    return BackupService(
      dataRoot: root,
      dbFilePath: p.join(docs.path, 'math_wrong_notebook.db'),
    );
  }

  Future<void> _exportBackup() async {
    setState(() => _busy = true);
    try {
      final svc = await _service();
      final zip = await svc.exportZip();
      if (!mounted) return;
      await Share.shareXFiles(<XFile>[XFile(zip, mimeType: 'application/zip')]);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('备份失败：$e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _restoreBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const <String>['zip'],
    );
    if (result == null || result.files.single.path == null) return;
    setState(() => _busy = true);
    try {
      final svc = await _service();
      await svc.stageRestore(result.files.single.path!);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('校验通过，已暂存。重启应用后完成恢复。')),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('恢复失败：$e')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }
}

