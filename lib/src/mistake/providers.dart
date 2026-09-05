import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_wrong_notebook/src/mistake/ai/ai_actions.dart';
import 'package:smart_wrong_notebook/src/mistake/ai/ai_chat_client.dart';
import 'package:smart_wrong_notebook/src/mistake/ai/ai_settings.dart';
import 'package:smart_wrong_notebook/src/mistake/db/mistake_database.dart';
import 'package:smart_wrong_notebook/src/mistake/services/image_quality.dart';
import 'package:smart_wrong_notebook/src/mistake/storage/mistake_image_store.dart';

final Provider<MistakeDatabase> mistakeDbProvider =
    Provider<MistakeDatabase>((ref) => MistakeDatabase());

final Provider<MistakeImageStore> mistakeImageStoreProvider =
    Provider<MistakeImageStore>((ref) => const MistakeImageStore());

final Provider<MistakeImageQuality> imageQualityProvider =
    Provider<MistakeImageQuality>((ref) => const MistakeImageQuality());

final Provider<AiSettingsStore> aiSettingsStoreProvider =
    Provider<AiSettingsStore>((ref) => SecureAiSettingsStore());

final Provider<AiChatClient> aiChatClientProvider =
    Provider<AiChatClient>((ref) {
  return OpenAiChatClient(settings: ref.read(aiSettingsStoreProvider));
});

final Provider<AiActions> aiActionsProvider = Provider<AiActions>((ref) {
  return AiActions(
    db: ref.read(mistakeDbProvider),
    chat: ref.read(aiChatClientProvider),
    settings: ref.read(aiSettingsStoreProvider),
  );
});

/// 所有试卷，按最近更新排序。
final watchPapersProvider =
    StreamProvider<List<Paper>>((ref) => ref.watch(mistakeDbProvider).watchPapers());

final watchPagesOfPaperProvider =
    StreamProvider.family<List<PageRecord>, int>(
        (ref, paperId) =>
            ref.watch(mistakeDbProvider).watchPagesOfPaper(paperId));

final watchAllQuestionsProvider = StreamProvider<List<Question>>(
    (ref) => ref.watch(mistakeDbProvider).watchQuestions());

final watchQuestionsOfPaperProvider = StreamProvider.family<List<Question>, int>(
    (ref, paperId) =>
        ref.watch(mistakeDbProvider).watchQuestionsOfPaper(paperId));

final watchBlocksOfQuestionProvider =
    StreamProvider.family<List<Block>, int>((ref, questionId) {
  return ref.watch(mistakeDbProvider).watchBlocksOfQuestion(questionId);
});

final paperByIdProvider = StreamProvider.family<Paper?, int>(
    (ref, id) => ref.watch(mistakeDbProvider).watchPaper(id));

final pageByIdProvider = StreamProvider.family<PageRecord?, int>(
    (ref, id) => ref.watch(mistakeDbProvider).watchPage(id));

final questionByIdProvider = StreamProvider.family<Question?, int>(
    (ref, id) => ref.watch(mistakeDbProvider).watchQuestion(id));
