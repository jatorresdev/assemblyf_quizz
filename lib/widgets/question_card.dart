import 'package:flutter/material.dart';
import 'package:assemblyf_quizz/widgets/answers.dart';
import 'package:assemblyf_quizz/models/question.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
    required this.index,
  }) : super(key: key);

  final Question question;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
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
            Answers(
              correctAnswer: question.correctAnswer,
              incorrectAnswers: question.incorrectAnswers,
            ),
          ],
        ),
      ),
    );
  }
}
