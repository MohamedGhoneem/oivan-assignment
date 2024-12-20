
import 'package:oivan_assignment/features/users/domain/entity/request_entity.dart';


class RequestModel extends RequestEntity {
  RequestModel({
     super.site, required super.paginationRequestEntity,
  });

  Map<String, dynamic> toJson() => {
    'site': site,
    'page': paginationRequestEntity?.page,
    'pageSize': paginationRequestEntity?.pageSize,

  };
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RequestModel &&
              runtimeType == other.runtimeType &&
              paginationRequestEntity == other.paginationRequestEntity &&
              site == other.site;

  @override
  int get hashCode => Object.hash(paginationRequestEntity, site);
}