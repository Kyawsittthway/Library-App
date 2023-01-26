import 'package:library_app/data.vo/models/shelf_model.dart';

import '../../persistence/dao/shelf_dao.dart';
import '../../persistence/impl/shelf_dao_impl.dart';
import '../book_vo.dart';
import '../shelf_vo.dart';
import 'package:stream_transform/stream_transform.dart';

class ShelfModelImpl extends ShelfModel {

  @override
  static final ShelfModelImpl _singleton = ShelfModelImpl._internal();

  factory ShelfModelImpl() {
    return _singleton;
  }

  ShelfModelImpl._internal() {}


  ShelfDao mShelfDao = ShelfDaoImpl();

  Stream<ShelfVO?> getShelfByShelfName(String shelfName) {
    return mShelfDao
        .getAllShelfEventStream()
        .startWith(mShelfDao.getShelfByNameStream(shelfName))
        .map((event) => mShelfDao.getShelfByName(shelfName));
  }

  Stream<List<ShelfVO>> getAllShelf(){
    return mShelfDao
        .getAllShelfEventStream()
        .startWith(mShelfDao.getAllShelfStream())
        .map((event) => mShelfDao.getAllShelf());
  }

  void addBookToShelf(BookVO book,String shelfName){
    mShelfDao.addBookToShelf(book, shelfName);
  }

  void addShelf(ShelfVO shelf){
    mShelfDao.saveShelf(shelf);
  }

  void updatedShelf(ShelfVO shelf){

  }

  void removeShelf(ShelfVO shelf){
    mShelfDao.deleteShelf(shelf.shelfName ?? "");
  }




  // void removeBook(String isbn, String shelfName) {
  //   print("Inputted isbn :: $bookList");
  //   //
  //   // print(bookList.where((element) => element.isbn13.c));
  //   print("!!!!! ${bookList}");
  //   ShelfVO? shelf = mShelfDao.getShelfByName(shelfName);
  //   shelf?.bookList = bookList;
  //   print("########### ${shelf?.bookList}");
  //   mShelfDao.saveShelf(shelf!);
  //   print("success");
  //   notifyListeners();
  // }
}
