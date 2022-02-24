class Answers {
  Answers({
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
  });

  late final String answerA;
  late final String answerB;
  late final String answerC;
  late final String answerD;

  factory Answers.fromMap(Map<String, dynamic> map) {
    return Answers(
      answerA: map['answerA'] as String,
      answerB: map['answerB'] as String,
      answerC: map['answerC'] as String,
      answerD: map['answerD'] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        "answerA": answerA,
        "answerB": answerB,
        "answerC": answerC,
        "answerD": answerD,
      };
}
