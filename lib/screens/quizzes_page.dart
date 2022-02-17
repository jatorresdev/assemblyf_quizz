import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:assemblyf_quizz/models/response.dart';
import 'package:assemblyf_quizz/repositories/quiz_repository.dart';
import 'package:assemblyf_quizz/widgets/quizz_card.dart';
import 'package:assemblyf_quizz/models/quiz.dart';

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _QuizzesPageState createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  List<Quiz> _quizzes = [];

  getAllQuizzes() async {
    try {
      EasyLoading.show(status: 'loading...');
      Response<Quiz> response = await QuizRepository().getQuizzess();

      setState(() {
        _quizzes = response.data;
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
    getAllQuizzes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              return orientation == Orientation.portrait &&
                      constraints.maxWidth < 576
                  ? widgetList()
                  : widgetGrid(constraints);
            },
          );
        },
      ),
    );
  }

  ListView widgetList() {
    return ListView.builder(
      itemCount: _quizzes.length,
      itemBuilder: (context, index) {
        return QuizzCard(
          quizz: _quizzes[index],
        );
      },
    );
  }

  GridView widgetGrid(BoxConstraints constraints) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: constraints.maxWidth >= 992 ? 3 : 2,
        childAspectRatio: constraints.maxWidth >= 1200 ? 5 : 4.6,
      ),
      itemCount: _quizzes.length,
      itemBuilder: (context, index) {
        return QuizzCard(
          quizz: _quizzes[index],
        );
      },
    );
  }
}
