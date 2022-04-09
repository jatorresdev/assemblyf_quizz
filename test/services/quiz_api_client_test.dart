import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';

import 'package:assemblyf_quizz/services/quiz_api_client.dart';

void main() {
  dotenv.testLoad();

  group("quiz api client fetch quizzes", () {
    test('success', () async {
      Future<http.Response> _mockRequest(http.Request request) async {
        if (request.url.toString().startsWith(
            'https://assemblyf-quiz-server.herokuapp.com/api/quizzes')) {
          return http.Response(
            File('test/test_resources/response_quiz_random.json')
                .readAsStringSync(),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          );
        }

        return http.Response('Error: Unknown endpoint', 404);
      }

      final quizApiClient = QuizApiClient(httpClient: MockClient(_mockRequest));
      final response = await quizApiClient.fetchQuizzes();

      expect(response.data.length, 3);
      expect(response.data[0].name, 'Sports');
      expect(response.meta?.pagination.total, 3);
    });

    test('failed', () async {
      Future<http.Response> _mockRequest(http.Request request) async =>
          http.Response('Error: Unknown endpoint', 404);

      final quizApiClient = QuizApiClient(httpClient: MockClient(_mockRequest));
      quizApiClient.fetchQuizzes().catchError((error, stackTrace) {
        expect(error,
            'Exception: An error occurred while retrieving the quizzes.');
      });
    });
  });

  group("quiz api client get score", () {
    test('success', () async {
      Future<http.Response> _mockRequest(http.Request request) async {
        if (request.url.toString().startsWith(
            'https://assemblyf-quiz-server.herokuapp.com/api/quizzes/1/score')) {
          return http.Response(
            File('test/test_resources/quiz_score_random.json')
                .readAsStringSync(),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          );
        }

        return http.Response('Error: Unknown endpoint', 404);
      }

      final quizApiClient = QuizApiClient(httpClient: MockClient(_mockRequest));
      final quizScore = await quizApiClient.score(1, '');

      expect(quizScore.quiz.name, 'Sports');
      expect(quizScore.quiz.description, 'Sports');
      expect(quizScore.answers.length, 1);
      expect(quizScore.questionCount, 10);
    });

    test('failed', () async {
      Future<http.Response> _mockRequest(http.Request request) async =>
          http.Response('Error: Unknown endpoint', 404);

      final quizApiClient = QuizApiClient(httpClient: MockClient(_mockRequest));
      quizApiClient.score(1, '').catchError((error, stackTrace) {
        expect(error, 'An error occurred when retrieving the quiz score.');
      });
    });
  });

  group("quiz api client get create", () {
    test('success', () async {
      Future<http.Response> _mockRequest(http.Request request) async {
        if (request.url.toString().startsWith(
            'https://assemblyf-quiz-server.herokuapp.com/api/quizzes')) {
          return http.Response(
            '{"data": ${File('test/test_resources/quiz_random.json').readAsStringSync()}}',
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          );
        }

        return http.Response('Error: Unknown endpoint', 404);
      }

      final quizApiClient = QuizApiClient(httpClient: MockClient(_mockRequest));
      final quiz = await quizApiClient.create('');

      expect(quiz.name, 'Sports');
      expect(quiz.description, 'Sports');
    });

    test('failed', () async {
      Future<http.Response> _mockRequest(http.Request request) async =>
          http.Response('Error: Unknown endpoint', 404);

      final quizApiClient = QuizApiClient(httpClient: MockClient(_mockRequest));
      quizApiClient.create('').catchError((error, stackTrace) {
        expect(error, 'An error occurred when creating a quiz.');
      });
    });
  });
}
