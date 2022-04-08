import 'dart:convert';
import 'dart:io';

import 'package:assemblyf_quizz/models/question.dart';
import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/models/response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("quiz response", () {
    test('create a quiz response from json', () {
      final file = File('test/test_resources/response_quiz_random.json')
          .readAsStringSync();
      final response = Response<Quiz>.fromMap(jsonDecode(file));

      expect(response.data.length, 3);
      expect(response.data[0].name, 'Sports');
      expect(response.meta?.pagination.total, 3);
    });
  });

  group("question response", () {
    test('create a question response from a json', () {
      final file = File('test/test_resources/response_question_random.json')
          .readAsStringSync();
      final response = Response<Question>.fromMap(jsonDecode(file));

      expect(response.data.length, 10);
      // expect(quizzes.data[0].name, 'Sports');
      expect(response.meta?.pagination.total, 10);
    });
  });

  group("empty response", () {
    test('create a question response from json', () {
      final file = File('test/test_resources/response_question_random.json')
          .readAsStringSync();
      final response = Response.fromMap(jsonDecode(file));

      expect(response.data.length, 0);
    });
  });
}
