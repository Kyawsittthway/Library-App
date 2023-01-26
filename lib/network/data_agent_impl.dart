import 'package:dio/dio.dart';
import 'package:library_app/data.vo/book_vo.dart';
import 'package:library_app/data.vo/list_vo.dart';
import 'package:library_app/network/book_api.dart';
import 'package:library_app/network/book_data_agent.dart';

import '../data.vo/books_by_list_name_result_vo.dart';
import '../data.vo/books_by_list_name_vo.dart';

class DataAgentImpl extends BookDataAgent {
  late BookAPI mApi;

  static final DataAgentImpl _singleton = DataAgentImpl._internal();

  factory DataAgentImpl() {
    return _singleton;
  }

  DataAgentImpl._internal() {
    final dio = Dio();
    mApi = BookAPI(dio);
  }

  @override
  Future<List<ListVO>> getBookCategories(String apiKey) {
    return mApi
        .getBookCategories(apiKey)
        .asStream()
        .map((event) => event.bookListResult?.categoryLists ?? [])
        .first;
  }

  @override
  Future<List<BooksByListNameVO>> getBooksByCategory(
      String apiKey, String listName) {
    return mApi
        .getBooksByCategory(apiKey, listName)
        .asStream()
        .map((response) => response.results ?? [])
        .first;
  }
}
