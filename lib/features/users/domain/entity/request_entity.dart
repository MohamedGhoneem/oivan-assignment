import 'package:oivan_assignment/core/common/pagination/pagination_request_entity.dart';

class RequestEntity {
  PaginationRequestEntity? paginationRequestEntity;
  String? site ;

  RequestEntity({
    required this.site,
    required this.paginationRequestEntity
  });
}
