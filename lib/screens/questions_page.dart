import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'package:assemblyf_quizz/repositories/question_repository.dart';
import 'package:assemblyf_quizz/models/notifiers/answer_bag.dart';
import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/models/response.dart';
import 'package:assemblyf_quizz/models/question.dart';
import 'package:assemblyf_quizz/widgets/question_card.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key, required this.quizz}) : super(key: key);

  final Quiz quizz;

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  List<Question> _questions = [];

  getAllQuestions() async {
    try {
      EasyLoading.show(status: 'loading...');
      Response<Question> response =
          await QuestionRepository().getQuestions(widget.quizz.id);

      setState(() {
        _questions = response.data;
        EasyLoading.dismiss();
        Provider.of<AnswerBag>(context, listen: false).removeAll();
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));

      EasyLoading.dismiss();
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    getAllQuestions();
  }

  @override
  Widget build(BuildContext context) {
    var answerBag = Provider.of<AnswerBag>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quizz.description),
        actions: [
          _questions.isNotEmpty &&
                  answerBag.correctAnswersCount == _questions.length
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
          );
        },
      ),
    );
  }
}
