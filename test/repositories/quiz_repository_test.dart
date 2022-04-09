import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';

import 'package:assemblyf_quizz/services/quiz_api_client.dart';
import 'package:assemblyf_quizz/repositories/quiz_repository.dart';
import 'package:assemblyf_quizz/models/correct_answer.dart';
import 'package:assemblyf_quizz/models/request_create_quiz.dart';
import 'package:assemblyf_quizz/models/question.dart';

void main() {
  dotenv.testLoad();

  group("quiz repository get quizzes", () {
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
      final quizRepository = QuizRepository(quizApiClient: quizApiClient);
      final response = await quizRepository.getQuizzess();

      expect(response.data.length, 3);
      expect(response.data[0].name, 'Sports');
      expect(response.meta?.pagination.total, 3);
    });

    test('failed', () async {
      Future<http.Response> _mockRequest(http.Request request) async =>
          http.Response('Error: Unknown endpoint', 404);

      final quizApiClient = QuizApiClient(httpClient: MockClient(_mockRequest));
      final quizRepository = QuizRepository(quizApiClient: quizApiClient);

      quizRepository.getQuizzess().catchError((error, stackTrace) {
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
      final quizRepository = QuizRepository(quizApiClient: quizApiClient);
      final file = File('test/test_resources/correct_answer_random.json')
          .readAsStringSync();
      final correctAnswer = CorrectAnswer.fromMap(jsonDecode(file));
      final answers = [correctAnswer, correctAnswer, correctAnswer];
      final quizScore = await quizRepository.getScore(1, answers);

      expect(quizScore.quiz.name, 'Sports');
      expect(quizScore.quiz.description, 'Sports');
      expect(quizScore.answers.length, 1);
      expect(quizScore.questionCount, 10);
    });

    test('failed', () async {
      Future<http.Response> _mockRequest(http.Request request) async =>
          http.Response('Error: Unknown endpoint', 404);

      final quizApiClient = QuizApiClient(httpClient: MockClient(_mockRequest));
      final quizRepository = QuizRepository(quizApiClient: quizApiClient);
      final file = File('test/test_resources/correct_answer_random.json')
          .readAsStringSync();
      final correctAnswer = CorrectAnswer.fromMap(jsonDecode(file));
      final answers = [correctAnswer, correctAnswer, correctAnswer];

      quizRepository.getScore(1, answers).catchError((error, stackTrace) {
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
      final quizRepository = QuizRepository(quizApiClient: quizApiClient);
      final file =
          File('test/test_resources/question_random.json').readAsStringSync();
      final question = Question.fromMap(jsonDecode(file));
      final questions = [question, question, question];
      final request = RequestCreateQuiz(
          name: 'Test', description: 'Test', questions: questions);
      final quiz = await quizRepository.create(request);

      expect(quiz.name, 'Sports');
      expect(quiz.description, 'Sports');
    });

    test('failed', () async {
      Future<http.Response> _mockRequest(http.Request request) async =>
          http.Response('Error: Unknown endpoint', 404);

      final quizApiClient = QuizApiClient(httpClient: MockClient(_mockRequest));
      final quizRepository = QuizRepository(quizApiClient: quizApiClient);
      final file =
          File('test/test_resources/question_random.json').readAsStringSync();
      final question = Question.fromMap(jsonDecode(file));
      final questions = [question, question, question];
      final request = RequestCreateQuiz(
          name: 'Test', description: 'Test', questions: questions);

      quizRepository.create(request).catchError((error, stackTrace) {
        expect(error, 'An error occurred when creating a quiz.');
      });
    });
  });
}
