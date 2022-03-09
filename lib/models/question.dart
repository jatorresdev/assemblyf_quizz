import 'package:assemblyf_quizz/models/answers.dart';

class Question {
  Question({
    required this.title,
    required this.answers,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
  });

  late final int? id;
  late final String title;
  late final Answers answers;
  late final DateTime? createdAt;
  late final DateTime? updatedAt;
  late final DateTime? publishedAt;

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as int?,
      title: map['attributes']['title'] as String,
      answers: Answers.fromMap(map['attributes']),
      createdAt: DateTime.parse(map['attributes']['createdAt']),
      updatedAt: DateTime.parse(map['attributes']['updatedAt']),
      publishedAt: DateTime.parse(map['attributes']['publishedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "answers": answers.toJson(),
        if (id != null) "id": id,
        if (createdAt != null) "createdAt": createdAt,
        if (updatedAt != null) "updatedAt": updatedAt,
        if (updatedAt != null) "publishedAt": updatedAt,
      };
}
