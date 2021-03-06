import 'dart:convert';

import 'package:assemblyf_quizz/models/correct_answer.dart';
import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/models/quiz_score.dart';
import 'package:assemblyf_quizz/models/request_create_quiz.dart';
import 'package:assemblyf_quizz/models/response.dart';
import 'package:assemblyf_quizz/services/quiz_api_client.dart';

class QuizRepository {
  final QuizApiClient quizApiClient;

  QuizRepository({QuizApiClient? quizApiClient})
      : quizApiClient = quizApiClient ?? QuizApiClient();

  Future<Response<Quiz>> getQuizzess() {
    return quizApiClient.fetchQuizzes();
  }

  Future<QuizScore> getScore(int quizId, List<CorrectAnswer> answers) {
    return quizApiClient.score(quizId, jsonEncode(answers));
  }

  Future<Quiz> create(RequestCreateQuiz requestCreateQuiz) {
    return quizApiClient.create(jsonEncode(requestCreateQuiz));
  }
}
