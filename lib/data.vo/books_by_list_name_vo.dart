

import 'package:json_annotation/json_annotation.dart';

import 'book_vo.dart';

part 'books_by_list_name_vo.g.dart';

@JsonSerializable()
class BooksByListNameVO{
  @JsonKey(name:'list_name')
  String? listName;

  @JsonKey(name:'book_details')
  List<BookVO>? bookDetail;

  BooksByListNameVO(this.listName, this.bookDetail);

  factory BooksByListNameVO.fromJson(Map<String,dynamic>json) => _$BooksByListNameVOFromJson(json);

  Map<String,dynamic>toJson()=>_$BooksByListNameVOToJson(this);
}
// {
// "status": "OK",
// "copyright": "Copyright (c) 2022 The New York Times Company.  All Rights Reserved.",
// "num_results": 15,
// "last_modified": "2022-11-23T23:07:48-05:00",
// "results":
// [
// {
// "list_name": "Trade Fiction Paperback",
// "display_name": "Paperback Trade Fiction",
// "bestsellers_date": "2022-11-19",
// "published_date": "2022-12-04",
// "rank": 1,
// "rank_last_week": 1,
// "weeks_on_list": 5,
// "asterisk": 0,
// "dagger": 0,
// "amazon_product_url": "https://www.amazon.com/dp/1668001225?tag=NYTBSREV-20",
// "isbns":
// [
// {
// "isbn10": "1668001225",
// "isbn13": "9781668001226"
// },
// {
// "isbn10": "1668001233",
// "isbn13": "9781668001233"
// },
// {
// "isbn10": "179714510X",
// "isbn13": "9781797145105"
// }
// ],
// "book_details":
// [
// {
// "title": "IT STARTS WITH US",
// "description": "In the sequel to “It Ends With Us,” Lily deals with her jealous ex-husband as she reconnects with her first boyfriend.",
// "contributor": "by Colleen Hoover",
// "author": "Colleen Hoover",
// "contributor_note": "",
// "price": "0.00",
// "age_group": "",
// "publisher": "Atria",
// "primary_isbn13": "9781668001226",
// "primary_isbn10": "1668001225"
// }
// ],
// "reviews":
// [
// {
// "book_review_link": "",
// "first_chapter_link": "",
// "sunday_review_link": "",
// "article_chapter_link": ""
// }
// ]
// },