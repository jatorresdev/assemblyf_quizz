import 'package:flutter/material.dart';

class Answers extends StatefulWidget {
  Answers({
    Key? key,
    required this.incorrectAnswers,
    required this.correctAnswer,
    required this.isQuestionAnswered,
    required this.onChanged,
  }) : super(key: key);

  final List<String> incorrectAnswers;
  final String correctAnswer;
  final ValueChanged<bool> onChanged;
  final bool isQuestionAnswered;

  @override
  State<Answers> createState() => _AnswersState();
}

class _AnswersState extends State<Answers> {
  late List<String> answers;
  String _selectedAnswer = '';

  @override
  void initState() {
    answers = widget.incorrectAnswers;

    if (!answers.contains(widget.correctAnswer)) {
      answers.add(widget.correctAnswer);
      answers.shuffle();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.incorrectAnswers.map(
        (answer) {
          return RadioListTile(
            title: Text(answer),
            value: answer,
            groupValue: _selectedAnswer,
            onChanged: (newValue) {
              setState(() {
                _selectedAnswer = newValue.toString();
                widget.onChanged(widget.isQuestionAnswered);
              });
            },
          );
        },
      ).toList(),
    );
  }
}
