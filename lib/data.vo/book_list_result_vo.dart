
import 'package:json_annotation/json_annotation.dart';

import 'list_vo.dart';

part 'book_list_result_vo.g.dart';

@JsonSerializable()
class BookListResultVO{

  @JsonKey(name:'bestsellers_date')
  String? bestsellersDate;

  @JsonKey(name:'published_date')
  String? publishedDate;

  @JsonKey(name:'published_date_description')
  String? publishDateDescription;

  @JsonKey(name:'previous_published_date')
  String? previousPublishedDate;

  @JsonKey(name:'next_published_date')
  String? nextPublishedDate;

  @JsonKey(name:'lists')
  List<ListVO>? categoryLists;

  BookListResultVO(
      this.bestsellersDate,
      this.publishedDate,
      this.publishDateDescription,
      this.previousPublishedDate,
      this.nextPublishedDate,
      this.categoryLists);

  factory BookListResultVO.fromJson(Map<String,dynamic>json) => _$BookListResultVOFromJson(json);

  Map<String,dynamic>toJson()=>_$BookListResultVOToJson(this);
}

// "bestsellers_date": "2022-11-19",
// "published_date": "2022-12-04",
// "published_date_description": "latest",
// "previous_published_date": "2022-11-27",
// "next_published_date": "",
// "lists": [
// {
// "list_id": 704,
// "list_name": "Combined Print and E-Book Fiction",
// "list_name_encoded": "combined-print-and-e-book-fiction",
// "display_name": "Combined Print & E-Book Fiction",
// "updated": "WEEKLY",
// "list_image": null,
// "list_image_width": null,
// "list_image_height": null,
// "books": [