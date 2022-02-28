import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:assemblyf_quizz/models/correct_answer.dart';

class AnswersNotifier extends StateNotifier<List<CorrectAnswer>> {
  AnswersNotifier() : super([]);

  void add(CorrectAnswer correctAnswer) {
    List<CorrectAnswer> currentAnswers = List.from(state);

    final answers = currentAnswers
        .where((item) => item.questionId == correctAnswer.questionId);

    if (answers.isNotEmpty) {
      currentAnswers.remove(answers.first);
    }

    currentAnswers.add(correctAnswer);
    state = currentAnswers;
  }

  void removeAll() {
    List<CorrectAnswer> currentAnswers = List.from(state)..clear();
    state = currentAnswers;
  }
}
