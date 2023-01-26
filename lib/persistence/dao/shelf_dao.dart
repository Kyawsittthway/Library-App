import '../../data.vo/book_vo.dart';
import '../../data.vo/shelf_vo.dart';

abstract class ShelfDao{
  void saveShelf(ShelfVO shelf);
  void deleteShelf(String key);
  List<ShelfVO> getAllShelf();
  Stream<void> getAllShelfEventStream();
  Stream<List<ShelfVO>> getAllShelfStream();
  void addBookToShelf(BookVO book,String shelfName);
  ShelfVO? getShelfByName(String name);

  Stream<ShelfVO?> getShelfByNameStream(String name);
}