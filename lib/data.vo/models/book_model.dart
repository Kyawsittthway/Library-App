import '../books_by_list_name_result_vo.dart';
import '../books_by_list_name_vo.dart';
import '../list_vo.dart';

abstract class BookModel{
  void getBookCategories(String apiKey);
  Future<List<BooksByListNameVO>> getBooksByCategory(
      String apiKey, String listName);
  Stream<List<ListVO>> getBookCategoriesFromDatabase(String apiKey);
}