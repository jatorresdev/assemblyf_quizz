import 'dart:convert';
import 'dart:io';

import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("quiz", () {
    test('create a quiz from json', () {
      final file =
          File('test/test_resources/quiz_random.json').readAsStringSync();
      final quiz = Quiz.fromMap(jsonDecode(file));

      expect(quiz.name, 'Sports');
      expect(quiz.description, 'Sports');
    });

    test('convert a quiz to json', () {
      final file =
          File('test/test_resources/quiz_random.json').readAsStringSync();
      final quiz = Quiz.fromMap(jsonDecode(file));

      expect(quiz.toJson().toString(),
          '{id: 1, name: Sports, description: Sports, createdAt: 2022-02-18 02:56:07.502Z, updatedAt: 2022-02-18 02:58:44.364Z, publishedAt: 2022-02-18 02:58:44.360Z}');
    });
  });
}
