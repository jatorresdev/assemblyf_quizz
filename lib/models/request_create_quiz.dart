import 'package:flutter/foundation.dart';

import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/models/question.dart';

@immutable
class RequestCreateQuiz {
  const RequestCreateQuiz({
    required this.quiz,
    required this.questions,
  });

  final Quiz quiz;
  final List<Question> questions;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestCreateQuiz &&
          runtimeType == other.runtimeType &&
          quiz == other.quiz &&
          questions == other.questions;

  @override
  int get hashCode => Object.hash(quiz, questions);

  Map<String, dynamic> toJson() => {
        "quiz": quiz.toJson(),
        "questions": questions.map((question) => question.toJson()).toList(),
      };
}
