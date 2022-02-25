import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/models/quiz_score.dart';
import 'package:assemblyf_quizz/models/response.dart';

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
      return Future.error(
          Exception('An error occurred while retrieving the quizzes.'));
    }

    final quizzesJson = jsonDecode(quizzesResponse.body);

    Response<Quiz> quizzes = Response<Quiz>.fromMap(quizzesJson);

    return quizzes;
  }

  Future<QuizScore> score(int quizId, String data) async {
    final quizScoreUrl = '$baseUrl/quizzes/$quizId/score';

    final quizScoreResponse = await httpClient.post(Uri.parse(quizScoreUrl),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
        },
        body: data);

    if (quizScoreResponse.statusCode != 200) {
      throw 'An error occurred while retrieving the quizzes.';
    }

    final quizScoreJson = jsonDecode(quizScoreResponse.body);

    QuizScore quizScore = QuizScore.fromMap(quizScoreJson);

    return quizScore;
  }
}
