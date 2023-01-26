import 'package:hive/hive.dart';
import 'package:library_app/persistence/hive_constants.dart';

import '../../data.vo/list_vo.dart';
import '../dao/list_dao.dart';

class ListDaoImpl extends ListDao{
  static final ListDaoImpl _singleton = ListDaoImpl._internal();

  factory ListDaoImpl(){
    return _singleton;
  }

  ListDaoImpl._internal();


  void saveAllLists(List<ListVO>categoryList) async{
    Map<int,ListVO> listMap = Map.fromIterable(categoryList,key: (category)=>category.listId,value:(category)=>category);
    await getCategoryListBox().putAll(listMap);
  }

  List<ListVO> getAllCategoryLists(){
    return getCategoryListBox().values.toList();
  }

  Box<ListVO>getCategoryListBox(){
    return Hive.box<ListVO>(BOX_NAME_LIST_VO);
  }

  ///Reactive Programming
  Stream<void> getAllCategoryListEventStream(){
    return getCategoryListBox().watch();
  }
  Stream<List<ListVO>> getAllCategoryListStream(){
    return Stream.value(getAllCategoryLists()
        .toList());
  }
}