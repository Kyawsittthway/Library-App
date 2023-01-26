import '../book_vo.dart';

abstract class CurrentBookModel{
  Stream<List<BookVO>> getAllCurrentBooksFromDataBase();
  void addBookToCurrentList(BookVO book);
  void removeBookFromCurrentList(String isbn);
}