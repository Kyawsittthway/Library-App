// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_book_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookCategoriesResponse _$GetBookCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    GetBookCategoriesResponse(
      json['status'] as String?,
      json['copyRight'] as String?,
      json['num_results'] as int?,
      json['results'] == null
          ? null
          : BookListResultVO.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBookCategoriesResponseToJson(
        GetBookCategoriesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyRight': instance.copyRight,
      'num_results': instance.resultCount,
      'results': instance.bookListResult,
    };
