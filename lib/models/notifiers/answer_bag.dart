import 'dart:collection';

import 'package:assemblyf_quizz/models/correct_answer.dart';
import 'package:flutter/foundation.dart';

class AnswerBag extends ChangeNotifier {
  final List<CorrectAnswer> _correctAnswers = [];

  UnmodifiableListView<CorrectAnswer> get correctAnswers =>
      UnmodifiableListView(_correctAnswers);

  int get correctAnswersCount => _correctAnswers.length;

  void add(CorrectAnswer correctAnswer) {
    final answers = _correctAnswers
        .where((item) => item.questionId == correctAnswer.questionId);

    if (answers.isNotEmpty) {
      _correctAnswers.remove(answers.first);
    }

    _correctAnswers.add(correctAnswer);
    notifyListeners();
  }

  void removeAll() {
    _correctAnswers.clear();
    notifyListeners();
  }
}
