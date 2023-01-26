import 'package:flutter/cupertino.dart';
import 'package:library_app/data.vo/models/book_model.dart';
import 'package:library_app/data.vo/models/book_model_impl.dart';
import 'package:library_app/network/api_constants.dart';

import '../data.vo/book_vo.dart';
import '../data.vo/list_vo.dart';
import '../data.vo/models/current_book_model.dart';
import '../data.vo/models/current_book_model_impl.dart';

class HomeBloc extends ChangeNotifier{
  List<ListVO> categoryLists = [];
  List<BookVO> currentBookList = [];
  BookModel mBookModel = BookModelImpl();
  CurrentBookModel mCurrentBookModel = CurrentBookModelImpl();

  HomeBloc(){
    mBookModel.getBookCategoriesFromDatabase(API_KEY).listen((categories){
      categoryLists = categories;
      notifyListeners();
       // print(categoryLists.first.bookList?[1].description);
    }).onError((error){
      print("Error in getBookCategories :: $error");
    });

    mCurrentBookModel.getAllCurrentBooksFromDataBase().listen((books) {
      currentBookList = books;
      notifyListeners();
    }).onError((error){
      print("Home_Bloc getAllCurrentBooksFromDataBase error :: $error");
    });


  }
}