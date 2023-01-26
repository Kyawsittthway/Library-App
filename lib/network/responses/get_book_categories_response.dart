
import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data.vo/book_list_result_vo.dart';

part 'get_book_categories_response.g.dart';

@JsonSerializable()
class GetBookCategoriesResponse{

  @JsonKey(name:'status')
  String? status;


  @JsonKey(name:'copyRight')
  String? copyRight;


  @JsonKey(name:'num_results')
  int? resultCount;

  @JsonKey(name:'results')
  BookListResultVO? bookListResult;

  GetBookCategoriesResponse(
      this.status, this.copyRight, this.resultCount, this.bookListResult);

  factory GetBookCategoriesResponse.fromJson(Map<String,dynamic>json)=>_$GetBookCategoriesResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$GetBookCategoriesResponseToJson(this);
}