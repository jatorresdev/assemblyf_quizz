class CorrectAnswer {
  CorrectAnswer({
    required this.questionId,
    required this.questionAnswer,
  });

  late final int questionId;
  late final String questionAnswer;

  factory CorrectAnswer.fromMap(Map<String, dynamic> map) {
    return CorrectAnswer(
      questionId: map['questionId'] as int,
      questionAnswer: map['questionAnswer'] as String,
    );
  }
}
