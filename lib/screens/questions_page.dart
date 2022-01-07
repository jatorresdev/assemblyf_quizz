import 'package:flutter/material.dart';
import 'package:assemblyf_quizz/models/quizz.dart';
import 'package:assemblyf_quizz/widgets/question_card.dart';
import 'package:assemblyf_quizz/data/questions.dart';
import 'package:assemblyf_quizz/models/question.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key, required this.quizz}) : super(key: key);

  final Quizz quizz;

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  List<Question> _questions = [];
  final List<dynamic> _questionsAnswered = [];

  @override
  void initState() {
    _questions = questions
        .where((item) => item['quizz_id'] == widget.quizz.id)
        .map((question) => Question.fromMap(question))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quizz.name),
        actions: [
          _questionsAnswered.length == _questions.length
              ? IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Quiz submitted'),
                      content:
                          const Text('The quiz has been sent successfully!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: ListView.builder(
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          return QuestionCard(
            index: (index + 1),
            question: _questions[index],
            questionsAnswered: _questionsAnswered,
            onChanged: (bool _inQuestionsAnswered) {
              setState(() {
                if (!_inQuestionsAnswered) {
                  _questionsAnswered.add(_questions[index].title);
                }
              });
            },
          );
        },
      ),
    );
  }
}
