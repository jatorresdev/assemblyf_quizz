import 'dart:convert';
import 'dart:io';

import 'package:assemblyf_quizz/models/correct_answer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("correct answer", () {
    test('create a correct answer from json', () {
      final file = File('test/test_resources/correct_answer_random.json')
          .readAsStringSync();
      final correctAnswer = CorrectAnswer.fromMap(jsonDecode(file));

      expect(correctAnswer.correct, false);
      expect(correctAnswer.question,
          '¿At which bridge does the annual Oxford and Cambridge boat race start?');
      expect(correctAnswer.questionAnswer, 'Vauxhall');
      expect(correctAnswer.questionId, 1);
    });

    test('convert a correct answer to json', () {
      final file = File('test/test_resources/correct_answer_random.json')
          .readAsStringSync();
      final correctAnswer = CorrectAnswer.fromMap(jsonDecode(file));

      expect(correctAnswer.toJson().toString(),
          '{questionId: 1, questionAnswer: Vauxhall, question: ¿At which bridge does the annual Oxford and Cambridge boat race start?, correct: false}');
    });
  });
}
