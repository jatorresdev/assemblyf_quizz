import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:assemblyf_quizz/models/correct_answer.dart';
import 'package:assemblyf_quizz/models/question.dart';
import 'package:assemblyf_quizz/providers/answers_provider.dart';

class AnswersGrid extends ConsumerStatefulWidget {
  const AnswersGrid({
    Key? key,
    required this.question,
    required this.isLandscape,
  }) : super(key: key);

  final Question question;
  final bool isLandscape;

  @override
  _AnswersGridState createState() => _AnswersGridState();
}

class _AnswersGridState extends ConsumerState<AnswersGrid> {
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
    final answersProviderRef = ref.read(answersProvider.notifier);

    return RadioListTile(
      title: Text(answer.value),
      value: answer.value,
      groupValue: _selectedAnswer,
      onChanged: (newValue) {
        setState(() {
          _selectedAnswer = newValue.toString();

          answersProviderRef.add(CorrectAnswer(
            questionId: widget.question.id,
            questionAnswer: _selectedAnswer,
          ));
        });
      },
    );
  }
}
