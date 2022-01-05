class Quizz {
  Quizz({
    required this.id,
    required this.name,
    required this.description,
  });

  late final int id;
  late final String name;
  late final String description;

  factory Quizz.fromMap(Map<String, dynamic> map) {
    return Quizz(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }
}
