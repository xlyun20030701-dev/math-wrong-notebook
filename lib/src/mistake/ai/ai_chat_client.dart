import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'ai_settings.dart';

/// AI 调用失败（统一映射为中文消息，绝不携带 API Key）。
class AiApiException implements Exception {
  AiApiException(this.message, {this.canRetry = true});

  final String message;
  final bool canRetry;

  @override
  String toString() => message;
}

/// 文本/视觉对话客户端（OpenAI Chat Completions 兼容）。
abstract interface class AiChatClient {
  Future<String> chat({
    required String system,
    required String user,
    List<Uint8List> images = const <Uint8List>[],
  });
}

/// OpenAI 兼容实现。baseUrl 默认 https://api.openai.com/v1
class OpenAiChatClient implements AiChatClient {
  OpenAiChatClient({
    required AiSettingsStore settings,
    Dio? dio,
    String baseUrl = 'https://api.openai.com/v1',
    this.imageMime = 'image/jpeg',
  })  : _settings = settings,
        _dio = dio ?? Dio(),
        _baseUrl = baseUrl;

  final AiSettingsStore _settings;
  final Dio _dio;
  final String _baseUrl;
  final String imageMime;

  @override
  Future<String> chat({
    required String system,
    required String user,
    List<Uint8List> images = const <Uint8List>[],
  }) async {
    final key = await _settings.apiKey();
    if (key == null || key.isEmpty) {
      throw AiApiException('尚未配置 OpenAI API Key，请先到「设置 → AI 设置」填写。');
    }
    final model = await _settings.model();

    final userContent = <Map<String, Object?>>[
      <String, Object?>{'type': 'text', 'text': user},
      for (final bytes in images)
        <String, Object?>{
          'type': 'image_url',
          'image_url': <String, Object?>{
            'url': 'data:$imageMime;base64,${base64Encode(bytes)}',
          },
        },
    ];

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '$_baseUrl/chat/completions',
        options: Options(
          headers: <String, Object?>{'Authorization': 'Bearer $key'},
          contentType: Headers.jsonContentType,
        ),
        data: <String, Object?>{
          'model': model,
          'messages': <Object?>[
            <String, Object?>{'role': 'system', 'content': system},
            <String, Object?>{'role': 'user', 'content': userContent},
          ],
          'temperature': 0.2,
          'max_tokens': 2400,
        },
      );
      final choices = response.data?['choices'];
      if (choices is! List || choices.isEmpty) {
        throw AiApiException('模型返回内容为空，请重试。');
      }
      final message = (choices.first as Map<String, dynamic>)['message'];
      final content = message is Map ? message['content'] : null;
      final text = content is String ? content.trim() : '';
      if (text.isEmpty) {
        throw AiApiException('模型返回内容为空，请重试。');
      }
      return text;
    } on AiApiException {
      rethrow;
    } on DioException catch (e) {
      throw _mapError(e);
    } catch (e) {
      throw AiApiException('AI 请求失败：$e');
    }
  }

  AiApiException _mapError(DioException e) {
    final status = e.response?.statusCode;
    switch (status) {
      case 401:
        return AiApiException('API Key 无效或已失效（401），请检查设置。', canRetry: false);
      case 403:
        return AiApiException('没有权限访问该模型（403）。', canRetry: false);
      case 404:
        return AiApiException('模型不存在或地址错误（404），请在设置中检查模型名。',
            canRetry: false);
      case 429:
        return AiApiException('请求过于频繁或额度不足（429），请稍后重试。');
      case 500:
      case 502:
      case 503:
        return AiApiException('模型服务暂时不可用（$status），请稍后重试。');
    }
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return AiApiException('网络超时，请检查网络后重试。');
    }
    if (e.type == DioExceptionType.connectionError) {
      return AiApiException('网络连接失败，请检查网络后重试。');
    }
    final body = e.response?.data;
    String detail = '';
    if (body is Map && body['error'] is Map) {
      final msg = (body['error'] as Map)['message'];
      if (msg is String) detail = msg;
    }
    final trimmed = detail.length > 160 ? '${detail.substring(0, 160)}…' : detail;
    return AiApiException('AI 请求失败（${status ?? '未知'}）：$trimmed');
  }
}

/// 便于测试：返回固定的预置文本。
class FakeAiChatClient implements AiChatClient {
  FakeAiChatClient({this.response = '', this.error, this.onCall});

  String response;
  AiApiException? error;
  void Function(String system, String user, List<Uint8List> images)? onCall;

  @override
  Future<String> chat({
    required String system,
    required String user,
    List<Uint8List> images = const <Uint8List>[],
  }) async {
    onCall?.call(system, user, images);
    if (error != null) throw error!;
    return response;
  }
}
