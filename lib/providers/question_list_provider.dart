import 'package:riverpod/riverpod.dart';

import 'package:assemblyf_quizz/models/question.dart';
import 'package:assemblyf_quizz/models/response.dart';
import 'package:assemblyf_quizz/repositories/question_repository.dart';

final questionRepositoryProvider = Provider((ref) => QuestionRepository());

final questionListProvider =
    FutureProvider.autoDispose.family<Response<Question>, int>((ref, quizId) {
  final repository = ref.watch(questionRepositoryProvider);
  ref.maintainState = true;

  return repository.getQuestions(quizId);
});
