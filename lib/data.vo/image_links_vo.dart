
import 'package:json_annotation/json_annotation.dart';

part 'image_links_vo.g.dart';

@JsonSerializable()
class ImageLinksVO{
  @JsonKey(name:'thumbnail')
  String? imagePath;

  ImageLinksVO(this.imagePath);

  factory ImageLinksVO.fromJson(Map<String,dynamic>json) => _$ImageLinksVOFromJson(json);

  Map<String,dynamic>toJson()=>_$ImageLinksVOToJson(this);
}

// "smallThumbnail": "http://books.google.com/books/publisher/content?id=Q3whEAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&imgtk=AFLRE702Mau8kJ2_6MkUTPowux44u-XV-074pSpXnIeWKQKWJOUc4--ZgFCY-EqZIAQxzYgKBL_n4ZesI8XRis7rPpFVeKKGn9ZNgs3f_PWdz1vovDENKT6q8cYZPHtwqX2Vy5qwokS9&source=gbs_api",
// "thumbnail": "http://books.google.com/books/publisher/content?id=Q3whEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE73FxexKur8hO5rsECO54z9LBxi9-inZ7tvU4X32QP1dQ5DAXIIbO0Qetf8PkPu8-RTTC1HRBVfrNpTW38h2naa0HNAcMEE5OCaqqWKxP3td7qH5QUC6s406Z0VPCUoK7RzA96rE&source=gbs_api",
// "small": "http://books.google.com/books/publisher/content?id=Q3whEAAAQBAJ&printsec=frontcover&img=1&zoom=2&edge=curl&imgtk=AFLRE71ATSRD3Zv3XSJuwx5y-sI4oDkQ1-jqs_7pcHSQLxM7vIoovQbmVT4MXbSueMUMW2xUnqQI9pd8mvOsNM3lfXOBhr4WUNj-Oht1TjveoqQIyQjz1AX64MiT8Efal_QFq3MNPsPu&source=gbs_api",
// "medium": "http://books.google.com/books/publisher/content?id=Q3whEAAAQBAJ&printsec=frontcover&img=1&zoom=3&edge=curl&imgtk=AFLRE71LNF2S9xJTGuNpnLOGGuohahUbkr9FvvUb7FpjmUT3mBEhkPoViXEGr6pxU922D2GHmDu8vHjmrFI0_2SpGzRdokxJQHqZDLUwkFwModc3S51AzlqEdhCB4f8QhyamJss7ZDVF&source=gbs_api",
// "large": "http://books.google.com/books/publisher/content?id=Q3whEAAAQBAJ&printsec=frontcover&img=1&zoom=4&edge=curl&imgtk=AFLRE73lAQlyFoDOvYGSg24DLQoxHIRjZI4HVTGZmj91Efo0HfY421tj5IUlkt_DJikUjhBhsHZtu9jwu0K1YtOdNcGlw4CIZGmOFV57IigEb2suV4g_g_j91OR9lo13OgfokKPd9gY7&source=gbs_api",
// "extraLarge": "http://books.google.com/b