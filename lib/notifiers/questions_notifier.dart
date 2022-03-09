import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:assemblyf_quizz/models/question.dart';

class QuestionsNotifier extends StateNotifier<List<Question>> {
  QuestionsNotifier() : super([]);

  void add(Question question, int? position) {
    List<Question> questions = List.from(state);

    if (questions.asMap().containsKey(position)) {
      questions[position!] = question;
    } else {
      questions.add(question);
    }

    state = questions;
  }

  void removeAll() {
    List<Question> questions = List.from(state)..clear();
    state = questions;
  }
}
