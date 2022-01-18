import 'package:assemblyf_quizz/widgets/quizz_card.dart';
import 'package:flutter/material.dart';
import 'package:assemblyf_quizz/data/quizzes.dart';
import 'package:assemblyf_quizz/models/quizz.dart';

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _QuizzesPageState createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  List<Quizz> _quizzes = [];

  @override
  void initState() {
    _quizzes = quizzes.map((quizz) => Quizz.fromMap(quizz)).toList();
    super.initState();
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
      itemCount: quizzes.length,
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
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        return QuizzCard(
          quizz: _quizzes[index],
        );
      },
    );
  }
}
