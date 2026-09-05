import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// AI 设置（仅保存在 Android 安全存储，绝不明文入库/入日志）。
abstract interface class AiSettingsStore {
  Future<String?> apiKey();
  Future<void> saveApiKey(String key);
  Future<void> deleteApiKey();
  Future<String> model();
  Future<void> saveModel(String model);
  bool get hasKey;
}

class SecureAiSettingsStore implements AiSettingsStore {
  SecureAiSettingsStore({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const String _keyKey = 'mistake_ai_api_key';
  static const String _modelKey = 'mistake_ai_model';
  static const String defaultModel = 'gpt-4o-mini';

  final FlutterSecureStorage _storage;

  @override
  Future<String?> apiKey() => _storage.read(key: _keyKey);

  @override
  Future<void> saveApiKey(String key) async {
    final trimmed = key.trim();
    if (trimmed.isEmpty) {
      await deleteApiKey();
      return;
    }
    await _storage.write(key: _keyKey, value: trimmed);
  }

  @override
  Future<void> deleteApiKey() => _storage.delete(key: _keyKey);

  @override
  Future<String> model() async =>
      await _storage.read(key: _modelKey) ?? defaultModel;

  @override
  Future<void> saveModel(String model) =>
      _storage.write(key: _modelKey, value: model.trim());

  @override
  bool get hasKey => false; // 仅 UI 参考；真实状态以 apiKey() 为准。
}

/// 内存实现（测试用，也用于“未配置”占位）。
class MemoryAiSettingsStore implements AiSettingsStore {
  String? _key;
  String _model = SecureAiSettingsStore.defaultModel;

  @override
  Future<String?> apiKey() async => _key;

  @override
  Future<void> saveApiKey(String key) async {
    _key = key.trim().isEmpty ? null : key.trim();
  }

  @override
  Future<void> deleteApiKey() async => _key = null;

  @override
  Future<String> model() async => _model;

  @override
  Future<void> saveModel(String model) async => _model = model.trim();

  @override
  bool get hasKey => _key != null;
}
