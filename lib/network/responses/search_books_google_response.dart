

import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data.vo/google_book_vo.dart';

part 'search_books_google_response.g.dart';

@JsonSerializable()
class SearchBooksGoogleResponse{

  @JsonKey(name:'kind')
  String? kind;

  @JsonKey(name:'totalItems')
  int? totalItems;

  @JsonKey(name:'items')
  List<GoogleBookVO>? bookLists;

  SearchBooksGoogleResponse(this.kind, this.totalItems, this.bookLists);

  factory SearchBooksGoogleResponse.fromJson(Map<String,dynamic>json)=>_$SearchBooksGoogleResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$SearchBooksGoogleResponseToJson(this);
}