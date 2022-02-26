import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:assemblyf_quizz/notifiers/answers_notifier.dart';
import 'package:assemblyf_quizz/models/correct_answer.dart';

final answersProvider =
    StateNotifierProvider.autoDispose<AnswersNotifier, List<CorrectAnswer>>(
        (ref) {
  return AnswersNotifier();
});
