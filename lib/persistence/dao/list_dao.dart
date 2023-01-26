import '../../data.vo/list_vo.dart';

abstract class ListDao{
  void saveAllLists(List<ListVO>categoryList);
  List<ListVO> getAllCategoryLists();
  Stream<void> getAllCategoryListEventStream();
  Stream<List<ListVO>> getAllCategoryListStream();
}