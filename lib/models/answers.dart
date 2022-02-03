class Answers {
  Answers({
    this.answerA,
    this.answerB,
    this.answerC,
    this.answerD,
    this.answerE,
    this.answerF,
  });

  late final String? answerA;
  late final String? answerB;
  late final String? answerC;
  late final String? answerD;
  late final String? answerE;
  late final String? answerF;

  factory Answers.fromMap(Map<String, dynamic> map) {
    return Answers(
      answerA: map['answer_a'] as String?,
      answerB: map['answer_b'] as String?,
      answerC: map['answer_c'] as String?,
      answerD: map['answer_d'] as String?,
      answerE: map['answer_e'] as String?,
      answerF: map['answer_f'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        "answer_a": answerA,
        "answer_b": answerB,
        "answer_c": answerC,
        "answer_d": answerD,
        "answer_f": answerE,
        "answer_e": answerF,
      };
}
