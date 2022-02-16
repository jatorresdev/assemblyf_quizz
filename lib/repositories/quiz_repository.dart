import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/models/response.dart';
import 'package:assemblyf_quizz/services/quiz_api_client.dart';

class QuizRepository {
  final QuizApiClient quizApiClient;

  QuizRepository({QuizApiClient? quizApiClient})
      : quizApiClient = quizApiClient ?? QuizApiClient();

  Future<Response<Quiz>> getQuizzess() async {
    final Response<Quiz> quizzes = await quizApiClient.fetchQuizzes();

    return quizzes;
  }
}
