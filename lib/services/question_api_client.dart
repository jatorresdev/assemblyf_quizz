import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:assemblyf_quizz/models/response.dart';
import 'package:assemblyf_quizz/models/question.dart';

class QuestionApiClient {
  static const baseUrl = "https://assemblyf-quiz-server.herokuapp.com/api";
  final bearerToken = dotenv.get('BEARER_TOKEN', fallback: '');
  final http.Client httpClient;

  QuestionApiClient({http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<Response<Question>> fetchQuestions(int quizId) async {
    final questionsUrl = '$baseUrl/questions?filters[quiz]=$quizId';

    final questionsResponse = await httpClient.get(
      Uri.parse(questionsUrl),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
      },
    );

    if (questionsResponse.statusCode != 200) {
      throw 'An error occurred while retrieving the questions.';
    }

    final questionsJson = jsonDecode(questionsResponse.body);

    Response<Question> questions = Response<Question>.fromMap(questionsJson);

    return questions;
  }
}
