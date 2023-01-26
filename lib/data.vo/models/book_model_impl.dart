import 'package:library_app/data.vo/books_by_list_name_vo.dart';
import 'package:library_app/data.vo/list_vo.dart';
import 'package:library_app/data.vo/models/book_model.dart';
import 'package:library_app/network/book_data_agent.dart';
import 'package:library_app/network/data_agent_impl.dart';
import 'package:library_app/persistence/impl/list_dao_impl.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../persistence/dao/list_dao.dart';
import '../book_vo.dart';
import '../books_by_list_name_result_vo.dart';

class BookModelImpl extends BookModel {
  BookDataAgent mDataAgent = DataAgentImpl();
  @override
  static final BookModelImpl _singleton = BookModelImpl._internal();

  factory BookModelImpl() {
    return _singleton;
  }

  BookModelImpl._internal() {}

  ListDao mListDao = ListDaoImpl();

  @override
  void getBookCategories(String apiKey) {
    mDataAgent.getBookCategories(apiKey).then((categories) async {
      // print("getBookCategories list name :: ${categories.first.listName}");
      List<ListVO> categoryList = categories.map((categoryLists) {
        // print("here before map");
        List<BookVO> books = categoryLists.bookList ?? [];
        for (var value in books) {
          value.listName = categoryLists.listName;
        }
        // books.map((e) {print("Sotana ");e.l istName = categoryLists.listName;print("here");});
        return categoryLists;
      }).toList();


      print(categoryList.first.bookList?.first.listName);
      print("getbook :: ${categoryList.first.bookList?.first.listName}");
      mListDao.saveAllLists(categoryList);
    });
  }

  @override
  Future<List<BooksByListNameVO>> getBooksByCategory(
      String apiKey, String listName) {
    return mDataAgent.getBooksByCategory(apiKey, listName);
  }

  @override
  Stream<List<ListVO>> getBookCategoriesFromDatabase(String apiKey) {
    this.getBookCategories(apiKey);
    return mListDao
        .getAllCategoryListEventStream()
        .startWith(mListDao.getAllCategoryListStream())
        .map((event) => mListDao.getAllCategoryLists());
  }


}
