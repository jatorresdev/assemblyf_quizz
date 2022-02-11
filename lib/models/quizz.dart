class Quizz {
  Quizz({
    required this.name,
    required this.description,
  });

  late final String name;
  late final String description;

  factory Quizz.fromMap(Map<String, dynamic> map) {
    return Quizz(
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }
}
