import 'package:assemblyf_quizz/models/pagination.dart';

class Meta {
  Meta({
    required this.pagination,
  });

  late final Pagination pagination;

  factory Meta.fromMap(Map<String, dynamic> map) {
    return Meta(
      pagination: Pagination.fromMap(map['pagination']),
    );
  }
}
