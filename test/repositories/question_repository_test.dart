import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';

import 'package:assemblyf_quizz/services/question_api_client.dart';
import 'package:assemblyf_quizz/repositories/question_repository.dart';

void main() {
  dotenv.testLoad();

  group("question repository get questions", () {
    test('success', () async {
      Future<http.Response> _mockRequest(http.Request request) async {
        if (request.url.toString().startsWith(
            'https://assemblyf-quiz-server.herokuapp.com/api/questions')) {
          return http.Response(
            File('test/test_resources/response_question_random.json')
                .readAsStringSync(),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
          );
        }

        return http.Response('Error: Unknown endpoint', 404);
      }

      final questionApiClient =
          QuestionApiClient(httpClient: MockClient(_mockRequest));
      final questionRepository =
          QuestionRepository(questionApiClient: questionApiClient);
      final response = await questionRepository.getQuestions(1);

      expect(response.data.length, 10);
      expect(response.data[0].title,
          '¿At which bridge does the annual Oxford and Cambridge boat race start?');
      expect(response.meta?.pagination.total, 10);
    });

    test('failed', () async {
      Future<http.Response> _mockRequest(http.Request request) async =>
          http.Response('Error: Unknown endpoint', 404);

      final questionApiClient =
          QuestionApiClient(httpClient: MockClient(_mockRequest));
      final questionRepository =
          QuestionRepository(questionApiClient: questionApiClient);

      questionRepository.getQuestions(1).catchError((error, stackTrace) {
        expect(error, 'An error occurred while retrieving the questions.');
      });
    });
  });
}
