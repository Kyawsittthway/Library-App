import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data.vo/image_links_vo.dart';
import 'package:library_app/data.vo/industry_identifier_vo.dart';


part 'volume_info_vo.g.dart';

@JsonSerializable()
class VolumeInfoVO{

  @JsonKey(name:'title')
  String? title;

  @JsonKey(name:'authors')
  List<String>? authors;

  @JsonKey(name:'publisher')
  String? publisher;

  @JsonKey(name:'description')
  String? description;

  @JsonKey(name:'industryIdentifiers')
  List<IndustryIdentifierVO>? industryIdentifiers;

  @JsonKey(name:'imageLinks')
  ImageLinksVO? imageLinks;

  @JsonKey(name:'categories')
  List<String>? listName;


  VolumeInfoVO(this.title, this.authors, this.publisher, this.description,
      this.industryIdentifiers, this.imageLinks, this.listName);

  factory VolumeInfoVO.fromJson(Map<String,dynamic>json) => _$VolumeInfoVOFromJson(json);

  Map<String,dynamic>toJson()=>_$VolumeInfoVOToJson(this);
}