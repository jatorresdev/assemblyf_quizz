import 'package:assemblyf_quizz/models/question.dart';
import 'package:assemblyf_quizz/services/question_api_client.dart';

class QuestionRepository {
  final QuestionApiClient questionApiClient;

  QuestionRepository({QuestionApiClient? questionApiClient})
      : questionApiClient = questionApiClient ?? QuestionApiClient();

  Future<List<Question>> getQuestions(String category) async {
    final List<Question> questions =
        await questionApiClient.fetchQuestions(category);

    return questions;
  }
}
