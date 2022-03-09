import 'package:flutter/foundation.dart';

import 'package:assemblyf_quizz/models/question.dart';

@immutable
class RequestCreateQuiz {
  const RequestCreateQuiz({
    required this.name,
    required this.description,
    required this.questions,
  });

  final String name;
  final String description;
  final List<Question> questions;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestCreateQuiz &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          questions == other.questions;

  @override
  int get hashCode => Object.hash(name, description, questions);

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "questions": questions
            .map((question) =>
                {"title": question.title, ...question.answers.toJson()})
            .toList(),
      };
}
