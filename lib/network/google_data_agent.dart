import 'package:library_app/data.vo/google_book_vo.dart';
import 'package:library_app/network/responses/search_books_google_response.dart';

abstract class GoogleDataAgent{

  Future<List<GoogleBookVO>> getResultFromGoogle(String keyword);
}