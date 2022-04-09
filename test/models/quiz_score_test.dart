import 'dart:convert';
import 'dart:io';

import 'package:assemblyf_quizz/models/quiz_score.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("quiz score", () {
    test('create a quiz score from json', () {
      final file =
          File('test/test_resources/quiz_score_random.json').readAsStringSync();
      final quizScore = QuizScore.fromMap(jsonDecode(file));

      expect(quizScore.quiz.name, 'Sports');
      expect(quizScore.quiz.description, 'Sports');
      expect(quizScore.answers.length, 1);
      expect(quizScore.questionCount, 10);
    });

    test('convert a quiz score to json', () {
      final file =
          File('test/test_resources/quiz_score_random.json').readAsStringSync();
      final quizScore = QuizScore.fromMap(jsonDecode(file));

      expect(quizScore.toJson().toString(),
          '{quiz: {id: 371, name: Sports, description: Sports, createdAt: 2022-02-18 02:56:07.502Z, updatedAt: 2022-02-18 02:58:44.364Z, publishedAt: 2022-02-18 02:58:44.360Z}, answers: [{questionId: 39, questionAnswer: Vauxhall, question: ¿At which bridge does the annual Oxford and Cambridge boat race start?, correct: false}], score: 0, questionCount: 10}');
    });

    test('copy a quiz score', () {
      final file =
          File('test/test_resources/quiz_score_random.json').readAsStringSync();
      final quizScore = QuizScore.fromMap(jsonDecode(file));
      final copyQuizScore = quizScore.copyWith(
        quiz: quizScore.quiz,
        answers: quizScore.answers,
        score: quizScore.score,
        questionCount: quizScore.questionCount,
        userIdFirebase: '1a2b3c',
      );

      expect(quizScore.quiz, copyQuizScore.quiz);
      expect(quizScore.answers, copyQuizScore.answers);
      expect(quizScore.score, copyQuizScore.score);
      expect(quizScore.questionCount, copyQuizScore.questionCount);
      expect(quizScore.userIdFirebase != copyQuizScore.userIdFirebase, true);
    });
  });
}
