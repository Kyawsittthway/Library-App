import 'package:hive/hive.dart';
import 'package:library_app/persistence/hive_constants.dart';

import '../../data.vo/book_vo.dart';
import '../dao/current_book_dao.dart';

class CurrentBookDaoImpl extends CurrentBookDao {
  BookVO? getBookByISBN(String ISBN) {
    return getCurrentBookBox().get(ISBN);
  }

  void saveBook(BookVO book) async {
    getCurrentBookBox().put(book.isbn13, book);
  }

  void deleteBook(String ISBN)async{
    return getCurrentBookBox().delete(ISBN);
  }

  List<BookVO> getAllCurrentBooks() {
    return getCurrentBookBox().values.toList();
  }

  Box<BookVO> getCurrentBookBox() {
    return Hive.box<BookVO>(BOX_NAME_CURRENT_BOOKS);
  }

  ///Reactive Programming
  Stream<void> getAllCurrentBooksEventStream(){
    return getCurrentBookBox().watch();
  }
  Stream<List<BookVO>> getAlLCurrentBooksStream(){
    return Stream.value(getAllCurrentBooks());
  }
}
