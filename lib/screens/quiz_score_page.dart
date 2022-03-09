import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/models/correct_answer.dart';
import 'package:assemblyf_quizz/models/request_quiz_score.dart';
import 'package:assemblyf_quizz/models/quiz_score.dart';
import 'package:assemblyf_quizz/providers/answers_provider.dart';
import 'package:assemblyf_quizz/providers/quiz_provider.dart';
import 'package:assemblyf_quizz/services/firebase/user_answers.dart';

class QuizScorePage extends ConsumerWidget {
  const QuizScorePage({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<CorrectAnswer> correctAnswers = ref.read(answersProvider);
    final RequestQuizScore requestQuizScore =
        RequestQuizScore(quiz: quiz, correctAnswers: correctAnswers);
    final quizScoreRef = ref.watch(quizScoreProvider(requestQuizScore));
    final UserAnswers _userAnswers = UserAnswers();

    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.name),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Text(
                'You scored:',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 80,
                width: 150,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Align(
                    alignment: Alignment.center,
                    child: quizScoreRef.when(
                      loading: () {
                        EasyLoading.show(status: 'We are grading the quiz...');

                        return const SizedBox.shrink();
                      },
                      error: (error, stack) {
                        EasyLoading.dismiss();

                        return Text(
                          '0/0',
                          style: Theme.of(context).textTheme.headline6,
                        );
                      },
                      data: (QuizScore responseQuizScore) {
                        EasyLoading.dismiss();
                        _userAnswers.add(responseQuizScore);

                        return Text(
                          '${responseQuizScore.score}/${responseQuizScore.questionCount}',
                          style: Theme.of(context).textTheme.headline6,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: const Text('Back to quizzes'),
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false),
              ),
            ],
          )
        ],
      ),
    );
  }
}
