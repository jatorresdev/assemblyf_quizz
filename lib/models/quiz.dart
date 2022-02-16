class Quiz {
  Quiz({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  late final int id;
  late final String name;
  late final String description;
  late final DateTime createdAt;
  late final DateTime updatedAt;
  late final DateTime publishedAt;

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'] as int,
      name: map['attributes']['name'] as String,
      description: map['attributes']['description'] as String,
      createdAt: DateTime.parse(map['attributes']['createdAt']),
      updatedAt: DateTime.parse(map['attributes']['updatedAt']),
      publishedAt: DateTime.parse(map['attributes']['publishedAt']),
    );
  }
}
