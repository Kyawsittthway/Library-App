import 'package:hive/hive.dart';
import 'package:library_app/persistence/hive_constants.dart';

import 'book_vo.dart';

part 'shelf_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_SHELF_VO,adapterName: "ShelfVOAdapter")
class ShelfVO{

  @HiveField(0)
  String? shelfName;

  @HiveField(1)
  List<BookVO> bookList = [];

  ShelfVO(this.shelfName);

}