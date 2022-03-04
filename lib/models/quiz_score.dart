import 'package:assemblyf_quizz/models/correct_answer.dart';
import 'package:assemblyf_quizz/models/quiz.dart';

class QuizScore {
  QuizScore({
    required this.quiz,
    required this.answers,
    required this.score,
    required this.questionCount,
    this.userIdFirebase,
  });

  late final Quiz quiz;
  late final List<CorrectAnswer> answers;
  late final int score;
  late final int questionCount;
  late final String? userIdFirebase;

  factory QuizScore.fromMap(Map<String, dynamic> map) {
    return QuizScore(
      quiz: Quiz.fromMap(map['quiz']),
      answers: (map['answers'] as List)
          .map((e) => CorrectAnswer.fromMap(e))
          .toList(),
      score: map['score'] as int,
      questionCount: map['questionCount'] as int,
      userIdFirebase: map['userIdFirebase'],
    );
  }

  Map<String, dynamic> toJson() => {
        "quiz": quiz.toJson(),
        "answers": answers.map((answer) => answer.toJson()).toList(),
        "score": score,
        "questionCount": questionCount,
        if (userIdFirebase != null) "userIdFirebase": userIdFirebase,
      };

  QuizScore copyWith({
    required Quiz quiz,
    required List<CorrectAnswer> answers,
    required int score,
    required int questionCount,
    String? userIdFirebase,
  }) {
    return QuizScore(
      quiz: quiz,
      answers: answers,
      score: score,
      questionCount: questionCount,
      userIdFirebase: userIdFirebase ?? this.userIdFirebase,
    );
  }
}
