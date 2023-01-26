// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_books_google_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBooksGoogleResponse _$SearchBooksGoogleResponseFromJson(
        Map<String, dynamic> json) =>
    SearchBooksGoogleResponse(
      json['kind'] as String?,
      json['totalItems'] as int?,
      (json['items'] as List<dynamic>?)
          ?.map((e) => GoogleBookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchBooksGoogleResponseToJson(
        SearchBooksGoogleResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.bookLists,
    };
