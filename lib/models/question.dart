class Question {
  Question({
    required this.quizzId,
    required this.difficulty,
    required this.title,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  late final int quizzId;
  late final String difficulty;
  late final String title;
  late final String correctAnswer;
  late final List<String> incorrectAnswers;

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      quizzId: map['quizz_id'] as int,
      difficulty: map['difficulty'] as String,
      title: map['title'] as String,
      correctAnswer: map['correct_answer'] as String,
      incorrectAnswers: map['incorrect_answers'] as List<String>,
    );
  }
}
