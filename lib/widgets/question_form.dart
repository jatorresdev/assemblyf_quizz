import 'package:flutter/material.dart';

class QuestionForm extends StatefulWidget {
  const QuestionForm(
      {Key? key, required this.position, required this.onChanged})
      : super(key: key);

  final int position;
  final void Function(
    int position,
    String title,
    String answerA,
    String answerB,
    String answerC,
    String answerD,
    String answerCorrect,
  ) onChanged;

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
  void dispose() {
    titleController.dispose();
    answerAController.dispose();
    answerBController.dispose();
    answerCController.dispose();
    answerDController.dispose();
    answerCorrectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        key: Key(widget.position.toString()),
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Question',
              ),
              onChanged: (value) {
                widget.onChanged(
                    widget.position,
                    value.trim(),
                    answerAController.text.trim(),
                    answerBController.text.trim(),
                    answerCController.text.trim(),
                    answerDController.text.trim(),
                    answerCorrectController.text.trim());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: answerAController,
              decoration: const InputDecoration(
                labelText: 'Answer A',
              ),
              onChanged: (value) {
                widget.onChanged(
                    widget.position,
                    titleController.text.trim(),
                    value.trim(),
                    answerBController.text.trim(),
                    answerCController.text.trim(),
                    answerDController.text.trim(),
                    answerCorrectController.text.trim());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: answerBController,
              decoration: const InputDecoration(
                labelText: 'Answer B',
              ),
              onChanged: (value) {
                widget.onChanged(
                    widget.position,
                    titleController.text.trim(),
                    answerAController.text.trim(),
                    value.trim(),
                    answerCController.text.trim(),
                    answerDController.text.trim(),
                    answerCorrectController.text.trim());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: answerCController,
              decoration: const InputDecoration(
                labelText: 'Answer C',
              ),
              onChanged: (value) {
                widget.onChanged(
                    widget.position,
                    titleController.text.trim(),
                    answerAController.text.trim(),
                    answerBController.text.trim(),
                    value.trim(),
                    answerDController.text.trim(),
                    answerCorrectController.text.trim());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: answerDController,
              decoration: const InputDecoration(
                labelText: 'Answer D',
              ),
              onChanged: (value) {
                widget.onChanged(
                    widget.position,
                    titleController.text.trim(),
                    answerAController.text.trim(),
                    answerBController.text.trim(),
                    answerCController.text.trim(),
                    value.trim(),
                    answerCorrectController.text.trim());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: answerCorrectController,
              decoration: const InputDecoration(
                labelText: 'Answer correct',
              ),
              onChanged: (value) {
                widget.onChanged(
                    widget.position,
                    titleController.text.trim(),
                    answerAController.text.trim(),
                    answerBController.text.trim(),
                    answerCController.text.trim(),
                    answerDController.text.trim(),
                    value.trim());
              },
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
