import 'package:flutter/material.dart';

enum TypeAnswer { text, image }

class Answers extends StatefulWidget {
  const Answers({
    Key? key,
    required this.incorrectAnswers,
    required this.correctAnswer,
    required this.isQuestionAnswered,
    required this.onChanged,
    required this.typeAnswer,
    required this.isLayoutRow,
  }) : super(key: key);

  final List<String> incorrectAnswers;
  final String correctAnswer;
  final ValueChanged<bool> onChanged;
  final bool isQuestionAnswered;
  final bool isLayoutRow;
  final TypeAnswer typeAnswer;

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
    return widget.isLayoutRow ? widgetRow() : widgetColumn();
  }

  Column widgetColumn() {
    return Column(
      children: widget.incorrectAnswers.map(
        (answer) {
          return boxAnswer(answer);
        },
      ).toList(),
    );
  }

  Row widgetRow() {
    return Row(
      children: widget.incorrectAnswers.map(
        (answer) {
          return Expanded(
            child: boxAnswer(answer),
          );
        },
      ).toList(),
    );
  }

  RadioListTile<String> boxAnswer(String answer) {
    return RadioListTile(
      title: (widget.typeAnswer == TypeAnswer.image
          ? FadeInImage(
              alignment: Alignment.centerLeft,
              width: 30,
              height: 30,
              placeholder: const AssetImage('assets/icon-flag.png'),
              image: NetworkImage(answer),
              fit: BoxFit.contain,
            )
          : Text(answer)),
      value: answer,
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
