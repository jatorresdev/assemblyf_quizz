import 'package:assemblyf_quizz/screens/create_quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:assemblyf_quizz/screens/signin_page.dart';
import 'package:assemblyf_quizz/screens/quizzes_page.dart';
import 'package:assemblyf_quizz/screens/signup_page.dart';
import 'package:assemblyf_quizz/screens/splash_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: QuizzApp()));
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
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/quizzes': (context) => const QuizzesPage(title: 'Quizz App'),
        '/create-quiz': (context) => const CreateQuizPage(),
        '/sign-in': (context) => const SigninPage(),
        '/sign-up': (context) => const SignupPage(),
      },
      builder: EasyLoading.init(),
    );
  }
}
