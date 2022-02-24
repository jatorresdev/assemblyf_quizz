import 'package:assemblyf_quizz/screens/questions_page.dart';
import 'package:flutter/material.dart';
import 'package:assemblyf_quizz/models/quiz.dart';

class QuizzCard extends StatelessWidget {
  const QuizzCard({
    Key? key,
    required this.quizz,
  }) : super(key: key);

  final Quiz quizz;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: ListTile(
        leading: Container(
          width: 30,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icon-quizz.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          quizz.name,
          overflow: TextOverflow.clip,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        subtitle: Text(
          quizz.description,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        trailing: Icon(
          Icons.chevron_right_outlined,
          color: Theme.of(context).primaryColor,
        ),
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return QuestionsPage(
                  quizz: quizz,
                );
              },
            ),
          )
        },
      ),
    );
  }
}
