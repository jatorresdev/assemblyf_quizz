import 'package:assemblyf_quizz/models/meta.dart';
import 'package:assemblyf_quizz/models/question.dart';
import 'package:assemblyf_quizz/models/quiz.dart';

class Response<T> {
  Response({
    required this.data,
    this.meta,
  });

  late final List<T> data;
  late final Meta? meta;

  factory Response.fromMap(Map<String, dynamic> map) {
    late final List<T> data;

    switch (T) {
      case Quiz:
        data = (map['data'] as List).map((e) => Quiz.fromMap(e)).toList()
            as List<T>;
        break;
      case Question:
        data = (map['data'] as List).map((e) => Question.fromMap(e)).toList()
            as List<T>;
        break;

      default:
        data = [];
        break;
    }

    return Response(
      data: data,
      meta: Meta.fromMap(map['meta']),
    );
  }
}
