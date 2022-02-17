import 'package:assemblyf_quizz/models/question.dart';
import 'package:assemblyf_quizz/models/response.dart';
import 'package:assemblyf_quizz/services/question_api_client.dart';

class QuestionRepository {
  final QuestionApiClient questionApiClient;

  QuestionRepository({QuestionApiClient? questionApiClient})
      : questionApiClient = questionApiClient ?? QuestionApiClient();

  Future<Response<Question>> getQuestions(int quizId) async {
    final Response<Question> questions =
        await questionApiClient.fetchQuestions(quizId);

    return questions;
  }
}
