import 'package:hive/hive.dart';

import '../../data.vo/book_vo.dart';

abstract class CurrentBookDao {
  BookVO? getBookByISBN(String ISBN);

  void saveBook(BookVO book);

  void deleteBook(String ISBN);

  List<BookVO> getAllCurrentBooks();

  Box<BookVO> getCurrentBookBox();

  ///Reactive Programming
  Stream<void> getAllCurrentBooksEventStream();

  Stream<List<BookVO>> getAlLCurrentBooksStream();
}
