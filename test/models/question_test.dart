import 'dart:convert';
import 'dart:io';

import 'package:assemblyf_quizz/models/question.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("question", () {
    test('create a question from json', () {
      final file =
          File('test/test_resources/question_random.json').readAsStringSync();
      final question = Question.fromMap(jsonDecode(file));

      expect(question.title,
          '¿At which bridge does the annual Oxford and Cambridge boat race start?');
      expect(question.answers.answerA, 'Battersea');
      expect(question.answers.answerB, 'Vauxhall');
      expect(question.answers.answerC, 'Putney');
      expect(question.answers.answerD, 'Hammersmith');
    });

    test('convert a question to json', () {
      final file =
          File('test/test_resources/question_random.json').readAsStringSync();
      final question = Question.fromMap(jsonDecode(file));

      expect(question.toJson().toString(),
          '{title: ¿At which bridge does the annual Oxford and Cambridge boat race start?, answers: {answerA: Battersea, answerB: Vauxhall, answerC: Putney, answerD: Hammersmith}, id: 1, createdAt: 2022-02-18 02:57:34.216Z, updatedAt: 2022-02-18 02:58:52.576Z, publishedAt: 2022-02-18 02:58:52.576Z}');
    });
  });
}
