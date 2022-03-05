import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:assemblyf_quizz/providers/quiz_provider.dart';
import 'package:assemblyf_quizz/models/response.dart';
import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/widgets/quizz_card.dart';

class QuizzesPage extends ConsumerWidget {
  const QuizzesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Response<Quiz>> quizListRef = ref.watch(quizListProvider);
    ref.listen(
      quizListProvider,
      (AsyncValue<Response<Quiz>>? previousResponse,
          AsyncValue<Response<Quiz>> newResponse) {
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
        title: Text(title),
        actions: [
          PopupMenuButton(
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.more_vert,
                ),
              ),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Create quiz"),
                  ),
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("Logout"),
                  ),
                ];
              },
              onSelected: (value) async {
                switch (value) {
                  case 1:
                    Navigator.of(context).pushNamed('/create-quiz');
                    break;
                  default:
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (Route<dynamic> route) => false,
                    );
                }
              }),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              return quizListRef.when(
                loading: () {
                  EasyLoading.show(status: 'loading...');

                  return const SizedBox.shrink();
                },
                error: (error, stack) {
                  EasyLoading.dismiss();

                  return const Center(
                    child: Text(
                      'No quizzes available',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                data: (responseQuiz) {
                  EasyLoading.dismiss();

                  return orientation == Orientation.portrait &&
                          constraints.maxWidth < 576
                      ? widgetList(responseQuiz.data)
                      : widgetGrid(responseQuiz.data, constraints);
                },
              );
            },
          );
        },
      ),
    );
  }

  ListView widgetList(List<Quiz> quizzes) {
    return ListView.builder(
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        return QuizzCard(
          quizz: quizzes[index],
        );
      },
    );
  }

  GridView widgetGrid(List<Quiz> quizzes, BoxConstraints constraints) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: constraints.maxWidth >= 992 ? 3 : 2,
        childAspectRatio: constraints.maxWidth >= 1200 ? 5 : 4.6,
      ),
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        return QuizzCard(
          quizz: quizzes[index],
        );
      },
    );
  }
}
