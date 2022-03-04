class CorrectAnswer {
  CorrectAnswer({
    required this.questionId,
    required this.questionAnswer,
    this.question,
    this.correct,
  });

  late final int questionId;
  late final String questionAnswer;
  late final String? question;
  late final bool? correct;

  factory CorrectAnswer.fromMap(Map<String, dynamic> map) {
    return CorrectAnswer(
      questionId: map['questionId'] as int,
      questionAnswer: map['questionAnswer'] as String,
      question: map['question'],
      correct: map['correct'],
    );
  }

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "questionAnswer": questionAnswer,
        if (question != null) "question": question,
        if (correct != null) "correct": correct,
      };
}
