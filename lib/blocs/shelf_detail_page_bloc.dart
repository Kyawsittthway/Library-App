import 'package:flutter/material.dart';
import 'package:library_app/data.vo/models/shelf_model_impl.dart';

import '../data.vo/book_vo.dart';
import '../data.vo/models/shelf_model.dart';
import '../data.vo/shelf_vo.dart';
import '../resource/enums.dart';

class ShelfDetailPageBloc extends ChangeNotifier {
  ///States
  List<BookVO> bookList = [];
  List<BookVO> filteredBookList = [];
  List<String> listTitles = [];

  ShelfVO? shelf;
  ViewStyle? view = null;
  SortStyle? sorting = null;
  int? filterSelectedIndex;
  String? updatedName;

  ///Models
  ShelfModel mShelfModel = ShelfModelImpl();

  ShelfDetailPageBloc(String shelfName,[String? updateShelfName]) {
    print("shelf name :: $shelfName ");
    // print("hi shelf");
    ///Get the respective shelf from the database
    mShelfModel.getShelfByShelfName(shelfName).listen((event) {
      // print("bool list length :: ${event?.bookList.length}");
      bookList = event?.bookList ?? [];
      filteredBookList = bookList;
      listTitles = bookList.map((e) => e.listName ?? "").toSet().toList();
      shelf = event;
      // print(
      //     " AWW :: ${bookList.map((e) => print("Book##### :: ${e.isbn13}"))}");
      notifyListeners();
    }).onError((error) {
      print("getShelfBySheflName error :: $error");
    });
  }

  void setViewStyle(ViewStyle style){
    this.view = style;
    notifyListeners();
  }

  void removeBookFromShelf(String isbn){
    filteredBookList.removeWhere((element) => element.isbn13 == isbn);
    mShelfModel.addShelf(shelf!);
    notifyListeners();

  }

  void removeShelf(){
    mShelfModel.removeShelf(shelf!);
  }

  void updateName(String value){
    updatedName = value;
    ShelfVO updatedShelf = ShelfVO(updatedName);
    updatedShelf.bookList = shelf?.bookList ?? [];
    print("updatedShelf.bookList :: ${updatedShelf.bookList}");
    print("shelf bookList :: ${shelf?.bookList}");
    removeShelf();
    mShelfModel.addShelf(updatedShelf);
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
      filteredBookList = bookList;
      notifyListeners();
    }else{
      print("index :: ${listTitles[index]}");
      filteredBookList = bookList.where((element) => element.listName == listTitles[index]).toList();
      notifyListeners();
    }
  }

}
