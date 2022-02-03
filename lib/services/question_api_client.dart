import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:assemblyf_quizz/models/question.dart';

class QuestionApiClient {
  static const baseUrl = "https://quizapi.io/api/v1";
  static const xApiKey = "X-Api-Key";
  final http.Client httpClient;

  QuestionApiClient({http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<List<Question>> fetchQuestions(String apiKey, String category,
      [int limit = 10]) async {
    final questionsUrl = '$baseUrl/questions?category=$category&limit=$limit';

    final questionsResponse = await httpClient.get(
      Uri.parse(questionsUrl),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        xApiKey: apiKey,
      },
    );

    if (questionsResponse.statusCode != 200) {
      throw 'Ha ocurrido un error al recuperar los pedidos.';
    }

    final questionsJson = jsonDecode(questionsResponse.body);

    List<Question> questions = [];

    for (var questionJson in questionsJson) {
      Question question = Question.fromMap(questionJson);
      questions.add(question);
    }

    return questions;
  }
}
