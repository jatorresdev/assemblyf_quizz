class Answers {
  Answers({
    required this.answerA,
    required this.answerB,
    required this.answerC,
    required this.answerD,
    this.answerCorrect,
  });

  late final String answerA;
  late final String answerB;
  late final String answerC;
  late final String answerD;
  late final String? answerCorrect;

  factory Answers.fromMap(Map<String, dynamic> map) {
    return Answers(
      answerA: map['answerA'] as String,
      answerB: map['answerB'] as String,
      answerC: map['answerC'] as String,
      answerD: map['answerD'] as String,
      answerCorrect: map['answerCorrect'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "answerA": answerA,
        "answerB": answerB,
        "answerC": answerC,
        "answerD": answerD,
        if (answerCorrect != null) "answerCorrect": answerCorrect
      };
}
