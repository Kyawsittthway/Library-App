// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_by_list_name_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksByListNameVO _$BooksByListNameVOFromJson(Map<String, dynamic> json) =>
    BooksByListNameVO(
      json['list_name'] as String?,
      (json['book_details'] as List<dynamic>?)
          ?.map((e) => BookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BooksByListNameVOToJson(BooksByListNameVO instance) =>
    <String, dynamic>{
      'list_name': instance.listName,
      'book_details': instance.bookDetail,
    };
