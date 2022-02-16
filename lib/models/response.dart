import 'package:assemblyf_quizz/models/meta.dart';
import 'package:assemblyf_quizz/models/quiz.dart';

class Response<T> {
  Response({
    required this.data,
    this.meta,
  });

  late final List<T> data;
  late final Meta? meta;

  factory Response.fromMap(Map<String, dynamic> map) {
    return Response(
      data:
          (map['data'] as List).map((e) => Quiz.fromMap(e)).toList() as List<T>,
      meta: Meta.fromMap(map['meta']),
    );
  }
}
