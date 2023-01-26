import 'package:json_annotation/json_annotation.dart';

import '../../data.vo/books_by_list_name_result_vo.dart';
import '../../data.vo/books_by_list_name_vo.dart';

part 'get_books_by_list_name_response.g.dart';

@JsonSerializable()
class GetBooksByListNameResponse{

  @JsonKey(name:'status')
  String? status;

  @JsonKey(name:'copyright')
  String? copyRight;

  @JsonKey(name:'num_results')
  int? resultCount;

  @JsonKey(name:'last_modified')
  String? lastModifiedDate;

  @JsonKey(name:'results')
  List<BooksByListNameVO>? results;

  GetBooksByListNameResponse(this.status, this.copyRight, this.resultCount,
      this.lastModifiedDate, this.results);

  factory GetBooksByListNameResponse.fromJson(Map<String,dynamic>json)=>_$GetBooksByListNameResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$GetBooksByListNameResponseToJson(this);
}

// "status": "OK",
// "copyright": "Copyright (c) 2022 The New York Times Company.  All Rights Reserved.",
// "num_results": 15,
// "last_modified": "2022-11-23T23:07:48-05:00",
// "results":