import 'package:flutter/material.dart';
import 'package:library_app/data.vo/models/current_book_model.dart';
import 'package:library_app/data.vo/models/current_book_model_impl.dart';

import '../data.vo/book_vo.dart';

class BookDetailPageBloc extends ChangeNotifier {

  BookVO? book;
  CurrentBookModel mCurrentBookModel = CurrentBookModelImpl();

  BookDetailPageBloc(BookVO? bookInfo) {
    book = bookInfo;

    if (book != null) {
      mCurrentBookModel.addBookToCurrentList(book!);
      mCurrentBookModel.getAllCurrentBooksFromDataBase().listen((books) {
        print(books);
      }).onError((error){
        print("Error in get all current books from database :: $error");
      });
      notifyListeners();
    }
  }

}
