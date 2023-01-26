import 'package:flutter/material.dart';
import 'package:library_app/data.vo/models/shelf_model.dart';
import 'package:library_app/data.vo/models/shelf_model_impl.dart';
import 'package:stream_transform/stream_transform.dart';
import '../data.vo/book_vo.dart';
import '../data.vo/shelf_vo.dart';
import '../persistence/dao/shelf_dao.dart';
import '../persistence/impl/shelf_dao_impl.dart';

class AddToShelvesPageBloc extends ChangeNotifier{
  List<ShelfVO> shelfList = [];

  ShelfModel mShelfModel = ShelfModelImpl();


  AddToShelvesPageBloc(){
    mShelfModel.getAllShelf().listen((shelves) {
      shelfList = shelves;
      notifyListeners();
    }).onError((error){
      print("Add to shelves page get all shelf error :: $error");
    });
  }

  void addBookToShelf(BookVO book,String shelfName){
    mShelfModel.addBookToShelf(book, shelfName);
  }


}