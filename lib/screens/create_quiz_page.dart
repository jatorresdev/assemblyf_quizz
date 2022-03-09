import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:assemblyf_quizz/models/answers.dart';
import 'package:assemblyf_quizz/models/question.dart';
import 'package:assemblyf_quizz/models/request_create_quiz.dart';
import 'package:assemblyf_quizz/widgets/question_form.dart';
import 'package:assemblyf_quizz/repositories/quiz_repository.dart';
import 'package:assemblyf_quizz/providers/creator_question_provider.dart';

class CreateQuizPage extends ConsumerStatefulWidget {
  const CreateQuizPage({Key? key}) : super(key: key);

  @override
  _CreateQuizPageState createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends ConsumerState<CreateQuizPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  StepperType stepperType = StepperType.vertical;
  final int countQuestions = 10;
  int _currentStep = 0;
  bool _isValid = false;

  onCreateQuiz() async {
    try {
      List<Question> questions = ref.read(creatorQuestionProvider);
      final RequestCreateQuiz requestCreateQuiz = RequestCreateQuiz(
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        questions: questions,
      );

      QuizRepository quizRepository = QuizRepository();
      quizRepository.create(requestCreateQuiz).whenComplete(
          () => Navigator.of(context).pushReplacementNamed('/quizzes'));
    } catch (e) {
      print(e);
    }
  }

  void addQuestion(
    int position,
    String title,
    String answerA,
    String answerB,
    String answerC,
    String answerD,
    String answerCorrect,
  ) {
    final creatorQuestionProviderRef =
        ref.read(creatorQuestionProvider.notifier);
    Answers answers = Answers.fromMap({
      "answerA": answerA,
      "answerB": answerB,
      "answerC": answerC,
      "answerD": answerD,
      "answerCorrect": answerCorrect,
    });
    creatorQuestionProviderRef.add(
        Question(title: title, answers: answers), position);

    if (title.isNotEmpty &&
        answers.answerA.isNotEmpty &&
        answers.answerB.isNotEmpty &&
        answers.answerC.isNotEmpty &&
        answers.answerD.isNotEmpty &&
        answers.answerCorrect!.isNotEmpty) {
      setState(() => _isValid = true);
    } else {
      setState(() => _isValid = false);
    }
  }

  continued() {
    _currentStep < (countQuestions - 1) && _isValid
        ? setState(() => _currentStep += 1)
        : null;

    if (_currentStep == (countQuestions - 1) && _isValid) {
      onCreateQuiz();
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create Quiz"),
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
          Expanded(
            child: Stepper(
              type: stepperType,
              physics: const ScrollPhysics(),
              currentStep: _currentStep,
              onStepTapped: (step) => tapped(step),
              onStepContinue: continued,
              onStepCancel: cancel,
              steps: <Step>[
                for (var i = 0; i < countQuestions; i++)
                  Step(
                    title: Text('Question ${i + 1}'),
                    content: QuestionForm(
                      position: i,
                      onChanged: addQuestion,
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
