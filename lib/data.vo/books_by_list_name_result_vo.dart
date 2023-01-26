import 'package:json_annotation/json_annotation.dart';

import 'books_by_list_name_vo.dart';

part 'books_by_list_name_result_vo.g.dart';

@JsonSerializable()
class BooksByListNameResultVO {

  @JsonKey(name: 'results')
  List<BooksByListNameVO>? bookLists;

  BooksByListNameResultVO(this.bookLists);

  factory BooksByListNameResultVO.fromJson(Map<String, dynamic> json) =>
      _$BooksByListNameResultVOFromJson(json);

  Map<String, dynamic> toJson() => _$BooksByListNameResultVOToJson(this);
}
