

import 'package:flutter/material.dart';
import 'package:library_app/network/api_constants.dart';


import '../data.vo/book_vo.dart';
import '../data.vo/books_by_list_name_vo.dart';
import '../data.vo/models/book_model.dart';
import '../data.vo/models/book_model_impl.dart';

class CollectionPageBloc extends ChangeNotifier{
  List<BookVO?> bookList = [];
  List<BooksByListNameVO?> rawList = [];
  BookModel mBookModel = BookModelImpl();

  CollectionPageBloc(String listName){
    // mBookModel.getBooksByCategory(API_KEY, listName).then((value){
    // rawList = value;
    // print(rawList.first?.bookDetail?.first.bookTitle);
    // insertValue();
    // }).catchError((error){
    //   print("getBooksByCategory error :: ${error}");
    // });
  }


}