// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list_result_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookListResultVO _$BookListResultVOFromJson(Map<String, dynamic> json) =>
    BookListResultVO(
      json['bestsellers_date'] as String?,
      json['published_date'] as String?,
      json['published_date_description'] as String?,
      json['previous_published_date'] as String?,
      json['next_published_date'] as String?,
      (json['lists'] as List<dynamic>?)
          ?.map((e) => ListVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookListResultVOToJson(BookListResultVO instance) =>
    <String, dynamic>{
      'bestsellers_date': instance.bestsellersDate,
      'published_date': instance.publishedDate,
      'published_date_description': instance.publishDateDescription,
      'previous_published_date': instance.previousPublishedDate,
      'next_published_date': instance.nextPublishedDate,
      'lists': instance.categoryLists,
    };
