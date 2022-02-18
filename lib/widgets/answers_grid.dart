import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:assemblyf_quizz/models/correct_answer.dart';
import 'package:assemblyf_quizz/models/notifiers/answer_bag.dart';
import 'package:assemblyf_quizz/models/question.dart';

class AnswersGrid extends StatefulWidget {
  const AnswersGrid({
    Key? key,
    required this.question,
    required this.isLandscape,
  }) : super(key: key);

  final Question question;
  final bool isLandscape;

  @override
  State<AnswersGrid> createState() => _AnswersGridState();
}

class _AnswersGridState extends State<AnswersGrid> {
  late Map<String, dynamic> _answers;
  String _selectedAnswer = '';

  @override
  void initState() {
    _answers = widget.question.answers.toMap();
    _answers.removeWhere((key, value) => value == null);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLandscape ? widgetGridView() : widgetColumn();
  }

  Column widgetColumn() {
    return Column(
      children: _answers.entries.map((answer) => boxAnswer(answer)).toList(),
    );
  }

  GridView widgetGridView() {
    return GridView.count(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 5.0,
      children: _answers.entries
          .map((answer) => GridTile(child: boxAnswer(answer)))
          .toList(),
    );
  }

  RadioListTile<String> boxAnswer(MapEntry<String, dynamic> answer) {
    var answerBag = context.read<AnswerBag>();

    return RadioListTile(
      title: Text(answer.value),
      value: answer.value,
      groupValue: _selectedAnswer,
      onChanged: (newValue) {
        setState(() {
          _selectedAnswer = newValue.toString();

          answerBag.add(CorrectAnswer(
              questionId: widget.question.id, questionAnswer: _selectedAnswer));
        });
      },
    );
  }
}
