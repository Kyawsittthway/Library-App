import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data.vo/volume_info_vo.dart';

import 'book_vo.dart';

part 'google_book_vo.g.dart';

@JsonSerializable()
class GoogleBookVO {

  @JsonKey(name: 'volumeInfo')
  VolumeInfoVO? volumeInfoVO;

  GoogleBookVO(this.volumeInfoVO);

  factory GoogleBookVO.fromJson(Map<String, dynamic>json) =>
      _$GoogleBookVOFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleBookVOToJson(this);


  BookVO toBookVO() {
    return BookVO(
        volumeInfoVO?.industryIdentifiers?.last.identifier,
        volumeInfoVO?.authors?.join(","),
        volumeInfoVO?.imageLinks?.imagePath,
        "",
        "",
        "",
        volumeInfoVO?.description,
        volumeInfoVO?.publisher,
        volumeInfoVO?.title,
        "",
        volumeInfoVO?.listName?.first);
  }
}
