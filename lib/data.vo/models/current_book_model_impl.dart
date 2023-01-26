import 'package:flutter/material.dart';
import 'package:library_app/persistence/impl/current_book_dao_impl.dart';

import '../../persistence/dao/current_book_dao.dart';
import '../book_vo.dart';
import 'current_book_model.dart';
import 'package:stream_transform/stream_transform.dart';

class CurrentBookModelImpl extends CurrentBookModel {
  @override
  static final CurrentBookModelImpl _singleton =
      CurrentBookModelImpl._internal();

  factory CurrentBookModelImpl() {
    return _singleton;
  }

  CurrentBookModelImpl._internal() {}

  CurrentBookDao mCurrentBookDao = CurrentBookDaoImpl();



  @override
  Stream<List<BookVO>> getAllCurrentBooksFromDataBase() {
    return mCurrentBookDao
        .getAllCurrentBooksEventStream()
        .startWith(mCurrentBookDao.getAlLCurrentBooksStream())
        .map((event) => mCurrentBookDao.getAllCurrentBooks());
  }

  @override
  void addBookToCurrentList(BookVO book) {
    mCurrentBookDao.saveBook(book);
  }

  void removeBookFromCurrentList(String isbn){
    mCurrentBookDao.deleteBook(isbn);
  }
}
