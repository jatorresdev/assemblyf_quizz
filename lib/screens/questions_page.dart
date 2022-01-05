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
      ),
      body: ListView.builder(
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
