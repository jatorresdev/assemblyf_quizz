import 'package:riverpod/riverpod.dart';

import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/models/response.dart';
import 'package:assemblyf_quizz/models/quiz_score.dart';
import 'package:assemblyf_quizz/models/request_quiz_score.dart';
import 'package:assemblyf_quizz/repositories/quiz_repository.dart';

final quizRepositoryProvider = Provider((ref) => QuizRepository());

final quizListProvider = FutureProvider.autoDispose<Response<Quiz>>((ref) {
  final repository = ref.watch(quizRepositoryProvider);
  ref.maintainState = true;

  return repository.getQuizzess();
});

final quizScoreProvider = FutureProvider.autoDispose
    .family<QuizScore, RequestQuizScore>((ref, requestQuizScore) {
  final repository = ref.watch(quizRepositoryProvider);
  final quizId = requestQuizScore.quiz.id;
  final correctAnswers = requestQuizScore.correctAnswers;
  ref.maintainState = true;

  return repository.getScore(quizId, correctAnswers);
});
