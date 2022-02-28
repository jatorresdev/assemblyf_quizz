import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/models/response.dart';
import 'package:assemblyf_quizz/models/question.dart';
import 'package:assemblyf_quizz/providers/question_list_provider.dart';
import 'package:assemblyf_quizz/providers/answers_provider.dart';
import 'package:assemblyf_quizz/screens/quiz_score_page.dart';
import 'package:assemblyf_quizz/widgets/question_card.dart';

class QuestionsPage extends ConsumerWidget {
  const QuestionsPage({Key? key, required this.quizz}) : super(key: key);

  final Quiz quizz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionListRef = ref.watch(questionListProvider(quizz.id));
    final answersProviderRef = ref.watch(answersProvider);

    ref.listen(
      questionListProvider(quizz.id),
      (AsyncValue<Response<Question>>? previousResponse,
          AsyncValue<Response<Question>> newResponse) {
        newResponse.maybeWhen(
          error: ((error, stackTrace) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error.toString()),
            ));
          }),
          orElse: () {},
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(quizz.description),
        actions: [
          answersProviderRef.isNotEmpty &&
                  answersProviderRef.length ==
                      questionListRef.asData?.value.data.length
              ? IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Quiz submitted'),
                      content:
                          const Text('The quiz has been sent successfully!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            // Close modal.
                            Navigator.of(context).pop();

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) {
                                  return QuizScorePage(
                                    quiz: quizz,
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: questionListRef.when(
        loading: () {
          EasyLoading.show(status: 'loading...');

          return const SizedBox.shrink();
        },
        error: (error, stack) {
          EasyLoading.dismiss();

          return const Center(
            child: Text(
              'No questions available',
              textAlign: TextAlign.center,
            ),
          );
        },
        data: (responseQuestion) {
          final List<Question> questions = responseQuestion.data;
          EasyLoading.dismiss();

          return ListView.builder(
            shrinkWrap: true,
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return QuestionCard(
                index: (index + 1),
                question: questions[index],
              );
            },
          );
        },
      ),
    );
  }
}
