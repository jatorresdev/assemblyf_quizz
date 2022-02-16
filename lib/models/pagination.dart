class Pagination {
  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  late final int page;
  late final int pageSize;
  late final int pageCount;
  late final int total;

  factory Pagination.fromMap(Map<String, dynamic> map) {
    return Pagination(
      page: map['page'],
      pageSize: map['pageSize'],
      pageCount: map['pageCount'],
      total: map['total'],
    );
  }
}
