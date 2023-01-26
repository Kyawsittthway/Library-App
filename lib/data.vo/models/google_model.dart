import '../google_book_vo.dart';

abstract class GoogleModel{
  Future<List<GoogleBookVO>> getResultFromGoogle(String keyword);
}