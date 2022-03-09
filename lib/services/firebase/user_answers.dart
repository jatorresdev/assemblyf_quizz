import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:assemblyf_quizz/models/quiz_score.dart';

class UserAnswers {
  final String collection = 'userAnswers';

  Future<void> add(QuizScore quizScore) async {
    try {
      QuizScore newQuizScore = quizScore.copyWith(
          quiz: quizScore.quiz,
          answers: quizScore.answers,
          score: quizScore.score,
          questionCount: quizScore.questionCount,
          userIdFirebase: FirebaseAuth.instance.currentUser!.uid);

      await FirebaseFirestore.instance
          .collection(collection)
          .add(newQuizScore.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
