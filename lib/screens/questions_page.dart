import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:assemblyf_quizz/providers/question_list_provider.dart';
import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/models/response.dart';
import 'package:assemblyf_quizz/models/question.dart';
import 'package:assemblyf_quizz/widgets/question_card.dart';

class QuestionsPage extends ConsumerWidget {
  const QuestionsPage({Key? key, required this.quizz}) : super(key: key);

  final Quiz quizz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionListRef = ref.watch(questionListProvider(quizz.id));

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
        actions: [],
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
