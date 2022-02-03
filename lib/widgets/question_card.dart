import 'package:flutter/material.dart';
import 'package:assemblyf_quizz/widgets/answers_grid.dart';
import 'package:assemblyf_quizz/models/question.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
    required this.questionsAnswered,
    required this.index,
    required this.onChanged,
  }) : super(key: key);

  final Question question;
  final List<dynamic> questionsAnswered;
  final int index;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    bool _isQuestionsAnswered = questionsAnswered.contains(question.title);

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            bool isLayoutRow = orientation == Orientation.portrait &&
                    constraints.maxWidth < 576
                ? false
                : true;

            return SizedBox(
              child: Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Text(
                        index.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(color: Colors.orange),
                      ),
                      title: Text(
                        question.title,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    AnswersGrid(
                      answers: question.answers,
                      isQuestionAnswered: _isQuestionsAnswered,
                      isLayoutRow: isLayoutRow,
                      onChanged: onChanged,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
