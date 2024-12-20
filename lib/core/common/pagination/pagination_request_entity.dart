
class PaginationRequestEntity {
  final int page;
  final int pageSize;

  PaginationRequestEntity({required this.page, required this.pageSize});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PaginationRequestEntity &&
              runtimeType == other.runtimeType &&
              page == other.page &&
              pageSize == other.pageSize;

  @override
  int get hashCode => Object.hash(page, pageSize);
}