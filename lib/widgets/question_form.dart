import 'package:flutter/material.dart';

class QuestionForm extends StatefulWidget {
  const QuestionForm({Key? key, required this.position}) : super(key: key);

  final int position;

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController answerAController = TextEditingController();
  TextEditingController answerBController = TextEditingController();
  TextEditingController answerCController = TextEditingController();
  TextEditingController answerDController = TextEditingController();
  TextEditingController answerCorrectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final int position = widget.position + 1;

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shadowColor: Colors.grey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text('Question $position'),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Question $position',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: answerAController,
              decoration: const InputDecoration(
                labelText: 'Answer A',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: answerBController,
              decoration: const InputDecoration(
                labelText: 'Answer B',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: answerCController,
              decoration: const InputDecoration(
                labelText: 'Answer C',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: answerDController,
              decoration: const InputDecoration(
                labelText: 'Answer D',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: answerCorrectController,
              decoration: const InputDecoration(
                labelText: 'Answer correct',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
