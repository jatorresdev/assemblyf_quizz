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
  }) : super(key: key);

  final List<String> incorrectAnswers;
  final String correctAnswer;
  final ValueChanged<bool> onChanged;
  final bool isQuestionAnswered;
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
    return Column(
      children: widget.incorrectAnswers.map(
        (answer) {
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
        },
      ).toList(),
    );
  }
}
