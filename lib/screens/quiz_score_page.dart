import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'package:assemblyf_quizz/repositories/quiz_repository.dart';
import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/models/notifiers/answer_bag.dart';
import 'package:assemblyf_quizz/models/quiz_score.dart';

class QuizScorePage extends StatefulWidget {
  const QuizScorePage({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  _QuizScorePageState createState() => _QuizScorePageState();
}

class _QuizScorePageState extends State<QuizScorePage> {
  QuizScore? _quizScore;

  getScore() async {
    try {
      EasyLoading.show(status: 'We are grading the quiz...');
      var answerBag = Provider.of<AnswerBag>(context, listen: false);
      var quizScore = await QuizRepository()
          .getScore(widget.quiz.id, answerBag.correctAnswers);

      setState(() {
        _quizScore = quizScore;
        EasyLoading.dismiss();
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
      ));

      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    getScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.name),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Text(
                'You scored:',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 80,
                width: 150,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Align(
                    alignment: Alignment.center,
                    child: (_quizScore != null
                        ? Text(
                            '${_quizScore?.score}/${_quizScore?.questionCount}',
                            style: Theme.of(context).textTheme.headline6,
                          )
                        : Text(
                            '0/0',
                            style: Theme.of(context).textTheme.headline6,
                          )),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: const Text('Back to quizzes'),
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false),
              ),
            ],
          )
        ],
      ),
    );
  }
}
