import 'package:dio/dio.dart';
import 'package:library_app/data.vo/book_vo.dart';
import 'package:library_app/data.vo/google_book_vo.dart';
import 'package:library_app/data.vo/list_vo.dart';
import 'package:library_app/network/book_api.dart';
import 'package:library_app/network/book_data_agent.dart';
import 'package:library_app/network/google_api.dart';
import 'package:library_app/network/google_data_agent.dart';

import '../data.vo/books_by_list_name_result_vo.dart';
import '../data.vo/books_by_list_name_vo.dart';

class GoogleDataAgentImpl extends GoogleDataAgent {
  late GoogleAPI mApi;

  static final GoogleDataAgentImpl _singleton = GoogleDataAgentImpl._internal();

  factory GoogleDataAgentImpl() {
    return _singleton;
  }

  GoogleDataAgentImpl._internal() {
    final dio = Dio();
    mApi = GoogleAPI(dio);
  }

  @override
  Future<List<GoogleBookVO>> getResultFromGoogle(String keyword) {
    return mApi.getResultFromGoogle(keyword)
        .asStream()
        .map((event) => event.bookLists ?? [])
        .first;
  }




}
