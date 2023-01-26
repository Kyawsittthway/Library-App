import 'package:hive/hive.dart';
import 'package:library_app/data.vo/shelf_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

import '../../data.vo/book_vo.dart';
import '../dao/shelf_dao.dart';

class ShelfDaoImpl extends ShelfDao{

    static final ShelfDaoImpl _singleton = ShelfDaoImpl._internal();

    factory ShelfDaoImpl(){
      return _singleton;
    }

    ShelfDaoImpl._internal();


    @override
    void deleteShelf(String key) async{
     return getShelfBox().delete(key);
    }

    @override
    void addBookToShelf(BookVO book,String shelfName)async{
      ShelfVO? shelf = getShelfByName(shelfName);
      shelf?.bookList.add(book);
      saveShelf(shelf!);
    }

    @override
    ShelfVO? getShelfByName(String name){
      return getShelfBox().get(name);
    }


    @override
    List<ShelfVO> getAllShelf() {
      return getShelfBox().values.toList();
    }

    @override
    void saveShelf(ShelfVO shelfVO) async {
       getShelfBox().put(shelfVO.shelfName,shelfVO);
    }



    Box<ShelfVO>getShelfBox(){
      return Hive.box<ShelfVO>(BOX_NAME_SHELF_VO);
    }

    ///Reactive Programming
    Stream<void> getAllShelfEventStream(){
      return getShelfBox().watch();
    }
    Stream<List<ShelfVO>> getAllShelfStream(){
      return Stream.value(getAllShelf()
          .toList());
    }

    @override
    Stream<ShelfVO?> getShelfByNameStream(String name){
      return Stream.value(getShelfBox().get(name));
    }

}