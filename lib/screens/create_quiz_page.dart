import 'package:flutter/material.dart';

import 'package:assemblyf_quizz/models/quiz.dart';
import 'package:assemblyf_quizz/models/request_create_quiz.dart';
import 'package:assemblyf_quizz/widgets/question_form.dart';
import 'package:assemblyf_quizz/repositories/quiz_repository.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({Key? key}) : super(key: key);

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int _count = 1;

  onCreateQuiz() async {
    try {
      final RequestCreateQuiz requestCreateQuiz = RequestCreateQuiz(
          name: nameController.text.trim(),
          description: descriptionController.text.trim(),
          questions: []);

      QuizRepository quizRepository = QuizRepository();
      await quizRepository.create(requestCreateQuiz);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create Quiz"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              setState(() {
                _count++;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Quiz',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _count,
              itemBuilder: (context, index) {
                return QuestionForm(
                  position: index,
                );
              },
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.orange),
            child: const Text("Add Quiz"),
            onPressed: onCreateQuiz),
      ),
    );
  }
}
