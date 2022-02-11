import 'package:flutter/material.dart';
import 'package:assemblyf_quizz/models/answers.dart';

enum TypeAnswer { text, image }

class AnswersGrid extends StatefulWidget {
  const AnswersGrid({
    Key? key,
    required this.answers,
    required this.isQuestionAnswered,
    required this.onChanged,
    required this.isLandscape,
  }) : super(key: key);

  final Answers answers;
  final ValueChanged<bool> onChanged;
  final bool isQuestionAnswered;
  final bool isLandscape;

  @override
  State<AnswersGrid> createState() => _AnswersGridState();
}

class _AnswersGridState extends State<AnswersGrid> {
  late Map<String, dynamic> _answers;
  String _selectedAnswer = '';

  @override
  void initState() {
    _answers = widget.answers.toMap();
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
    return RadioListTile(
      title: Text(answer.value),
      value: answer.key,
      groupValue: _selectedAnswer,
      onChanged: (newValue) {
        setState(() {
          _selectedAnswer = newValue.toString();
          widget.onChanged(widget.isQuestionAnswered);
        });
      },
    );
  }
}
