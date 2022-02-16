import 'dart:convert';
import 'dart:io';

import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/models/response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class QuizApiClient {
  static const baseUrl = "https://assemblyf-quiz-server.herokuapp.com/api";
  final bearerToken = dotenv.get('BEARER_TOKEN', fallback: '');
  final http.Client httpClient;

  QuizApiClient({http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<Response<Quiz>> fetchQuizzes() async {
    const quizzesUrl = '$baseUrl/quizzes';

    final quizzesResponse = await httpClient.get(
      Uri.parse(quizzesUrl),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
      },
    );

    if (quizzesResponse.statusCode != 200) {
      throw 'An error occurred while retrieving the quizzes.';
    }

    final quizzesJson = jsonDecode(quizzesResponse.body);

    Response<Quiz> quizzes = Response<Quiz>.fromMap(quizzesJson);

    return quizzes;
  }
}
