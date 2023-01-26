import '../book_vo.dart';
import '../shelf_vo.dart';

abstract class ShelfModel{
  Stream<ShelfVO?> getShelfByShelfName(String shelfName);
  Stream<List<ShelfVO>> getAllShelf();
  void addShelf(ShelfVO shelf);
  void removeShelf(ShelfVO shelf);
  void addBookToShelf(BookVO book,String shelfName);
}