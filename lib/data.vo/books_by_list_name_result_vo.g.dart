// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_by_list_name_result_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksByListNameResultVO _$BooksByListNameResultVOFromJson(
        Map<String, dynamic> json) =>
    BooksByListNameResultVO(
      (json['results'] as List<dynamic>?)
          ?.map((e) => BooksByListNameVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BooksByListNameResultVOToJson(
        BooksByListNameResultVO instance) =>
    <String, dynamic>{
      'results': instance.bookLists,
    };
