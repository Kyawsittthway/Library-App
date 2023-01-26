import 'package:library_app/data.vo/list_vo.dart';

import '../data.vo/books_by_list_name_result_vo.dart';
import '../data.vo/books_by_list_name_vo.dart';

abstract class BookDataAgent {
  Future<List<ListVO>> getBookCategories(String apiKey);

  Future<List<BooksByListNameVO>> getBooksByCategory(
      String apiKey, String listName);
}
