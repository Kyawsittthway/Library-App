// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListVOAdapter extends TypeAdapter<ListVO> {
  @override
  final int typeId = 3;

  @override
  ListVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListVO(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      (fields[4] as List?)?.cast<BookVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListVO obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.listId)
      ..writeByte(1)
      ..write(obj.listName)
      ..writeByte(2)
      ..write(obj.listNameEncoded)
      ..writeByte(3)
      ..write(obj.updated)
      ..writeByte(4)
      ..write(obj.bookList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListVO _$ListVOFromJson(Map<String, dynamic> json) => ListVO(
      json['list_id'] as int?,
      json['list_name'] as String?,
      json['list_name_encoded'] as String?,
      json['updated'] as String?,
      (json['books'] as List<dynamic>?)
          ?.map((e) => BookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListVOToJson(ListVO instance) => <String, dynamic>{
      'list_id': instance.listId,
      'list_name': instance.listName,
      'list_name_encoded': instance.listNameEncoded,
      'updated': instance.updated,
      'books': instance.bookList,
    };
