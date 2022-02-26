import 'package:flutter/foundation.dart';

import 'package:assemblyf_quizz/models/correct_answer.dart';
import 'package:assemblyf_quizz/models/quiz.dart';

@immutable
class RequestQuizScore {
  const RequestQuizScore({
    required this.quiz,
    required this.correctAnswers,
  });

  final Quiz quiz;
  final List<CorrectAnswer> correctAnswers;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestQuizScore &&
          runtimeType == other.runtimeType &&
          quiz == other.quiz &&
          correctAnswers == other.correctAnswers;

  @override
  int get hashCode => Object.hash(quiz, correctAnswers);
}
