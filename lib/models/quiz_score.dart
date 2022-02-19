import 'package:assemblyf_quizz/models/correct_answer.dart';
import 'package:assemblyf_quizz/models/quiz.dart';

class QuizScore {
  QuizScore({
    required this.quiz,
    required this.answers,
    required this.score,
    required this.questionCount,
  });

  late final Quiz quiz;
  late final List<CorrectAnswer> answers;
  late final int score;
  late final int questionCount;

  factory QuizScore.fromMap(Map<String, dynamic> map) {
    return QuizScore(
      quiz: Quiz.fromMap(map['quiz']),
      answers: (map['answers'] as List)
          .map((e) => CorrectAnswer.fromMap(e))
          .toList(),
      score: map['score'] as int,
      questionCount: map['questionCount'] as int,
    );
  }

  Map<String, dynamic> toMap() => {
        "quiz": quiz,
        "answers": answers,
        "score": score,
        "questionCount": questionCount,
      };
}
