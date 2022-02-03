import 'package:assemblyf_quizz/models/answers.dart';
import 'package:assemblyf_quizz/models/correct_answers.dart';

class Question {
  Question({
    required this.id,
    required this.title,
    required this.multipleCorrectAnswers,
    required this.category,
    required this.difficulty,
    required this.answers,
    required this.correctAnswers,
    this.description,
    this.explanation,
    this.tip,
  });

  late final int id;
  late final String title;
  late final bool multipleCorrectAnswers;
  late final String category;
  late final String difficulty;
  late final Answers answers;
  late final CorrectAnswers correctAnswers;
  late final String? description;
  late final String? explanation;
  late final String? tip;

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
        id: map['id'] as int,
        title: map['question'] as String,
        description: map['description'] as String?,
        multipleCorrectAnswers: map['multiple_correct_answers'] == "true",
        explanation: map['explanation'] as String?,
        tip: map['tip'] as String?,
        category: map['category'] as String,
        difficulty: map['difficulty'] as String,
        answers: Answers.fromMap(map['answers']),
        correctAnswers: CorrectAnswers.fromMap(map['correct_answers']));
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "question": title,
        "description": description,
        "multiple_correct_answers": multipleCorrectAnswers,
        "explanation": explanation,
        "tip": tip,
        "category": category,
        "difficulty": difficulty,
        "answers": answers.toMap(),
        "correct_answers": correctAnswers.toMap(),
      };
}
