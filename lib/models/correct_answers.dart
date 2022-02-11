class CorrectAnswers {
  CorrectAnswers({
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    required this.answerE,
    required this.answerF,
  });

  late final bool answerA;
  late final bool answerB;
  late final bool answerC;
  late final bool answerD;
  late final bool answerE;
  late final bool answerF;

  factory CorrectAnswers.fromMap(Map<String, dynamic> map) {
    return CorrectAnswers(
      answerA: map['answer_a_correct'] == "true",
      answerB: map['answer_b_correct'] == "true",
      answerC: map['answer_c_correct'] == "true",
      answerD: map['answer_d_correct'] == "true",
      answerE: map['answer_e_correct'] == "true",
      answerF: map['answer_f_correct'] == "true",
    );
  }

  Map<String, dynamic> toMap() => {
        "answer_a_correct": answerA,
        "answer_b_correct": answerB,
        "answer_c_correct": answerC,
        "answer_d_correct": answerD,
        "answer_f_correct": answerE,
        "answer_e_correct": answerF,
      };
}
