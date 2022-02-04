import 'package:flutter/material.dart';

import 'package:assemblyf_quizz/screens/quizzes_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const QuizzApp());
}

class QuizzApp extends StatelessWidget {
  const QuizzApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const QuizzesPage(title: 'Quizz App'),
      builder: EasyLoading.init(),
    );
  }
}
