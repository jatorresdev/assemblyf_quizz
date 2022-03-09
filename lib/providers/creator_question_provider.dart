import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:assemblyf_quizz/models/question.dart';
import 'package:assemblyf_quizz/notifiers/questions_notifier.dart';

final creatorQuestionProvider =
    StateNotifierProvider<QuestionsNotifier, List<Question>>((ref) {
  return QuestionsNotifier();
});
