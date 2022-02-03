import 'package:assemblyf_quizz/repositories/question_repository.dart';
import 'package:flutter/material.dart';
import 'package:assemblyf_quizz/models/quizz.dart';
import 'package:assemblyf_quizz/widgets/question_card.dart';
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

  getAllQuestions() async {
    try {
      List<Question> questions =
          await QuestionRepository().getQuestions(widget.quizz.name);
      setState(() {
        _questions = questions;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getAllQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quizz.description),
        actions: [
          _questions.isNotEmpty &&
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
        shrinkWrap: true,
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
