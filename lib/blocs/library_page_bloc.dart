import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data.vo/models/current_book_model_impl.dart';
import 'package:library_app/data.vo/models/shelf_model_impl.dart';
import 'package:library_app/persistence/impl/shelf_dao_impl.dart';
import 'package:library_app/resource/enums.dart';
import 'package:stream_transform/stream_transform.dart';
import '../data.vo/book_vo.dart';
import '../data.vo/models/current_book_model.dart';
import '../data.vo/models/shelf_model.dart';
import '../data.vo/shelf_vo.dart';
import '../persistence/dao/shelf_dao.dart';

class LibraryPageBloc extends ChangeNotifier{
  ///States
  List<ShelfVO> shelfList = [];
  List<BookVO> currentBookList = [];
  List<BookVO> filteredBookList = []; // to used in filtered section of library page
  List<String> listTitles = [];

  ViewStyle? view = null;
  SortStyle? sorting = null;
  int? filterSelectedIndex;


  ///Models
  ShelfModel mShelfModel = ShelfModelImpl();
  CurrentBookModel mCurrentBookModel = CurrentBookModelImpl();


  LibraryPageBloc(String shelfName){

    /// will add a new shelf if shelf name is passed
    if(shelfName == "" || shelfName.isEmpty){
      print("do nothing");
    }else{
      addShelf(shelfName);
    }

    ///fetch all shelves from database
    mShelfModel.getAllShelf().listen((shelves) {
      shelfList = shelves;
      print(shelfList);
      notifyListeners();
    }).onError((error){
      print("Error in getting all shelves :: $error");
    });


    ///fetch all current books from database
    mCurrentBookModel.getAllCurrentBooksFromDataBase().listen((books) {
      currentBookList = books;
      filteredBookList = currentBookList;
      // print("List name :: ${currentBookList.last.listName}");
      listTitles = currentBookList.map((e) => e.listName ?? "").toSet().toList();
    }).onError((error){
      print("Error is getAllCurrentBooksFromDataBase :: $error");
    });
  }

  void addShelf(String name){
    ShelfVO shelf = ShelfVO(name);
    mShelfModel.addShelf(shelf);
  }

  void removeBookFromCurrentList(String isbn13){
    mCurrentBookModel.removeBookFromCurrentList(isbn13);
    notifyListeners();
  }

  void setViewStyle(ViewStyle style){
    this.view = style;
    notifyListeners();
  }

  void setSortStyle(SortStyle style){
    List<BookVO> recents = filteredBookList;
    this.sorting = style;
    if(style == SortStyle.Recent || style == null){

      filteredBookList = recents;
    }else if(style == SortStyle.Author){
      filteredBookList.sort((book1, book2) => book1.authorName.toString().compareTo(book2.authorName.toString()));
    }else{
      filteredBookList.sort((book1, book2) => book1.bookTitle.toString().compareTo(book2.bookTitle.toString()));
    }
    notifyListeners();
  }




  void filterCurrentBooks(int? index){
    if(index == null){
      filteredBookList = currentBookList;
      notifyListeners();
    }else{
      print("index :: ${listTitles[index]}");
      filteredBookList = currentBookList.where((element) => element.listName == listTitles[index]).toList();
      notifyListeners();
    }
  }



}