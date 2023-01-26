
import 'package:dio/dio.dart';
import 'package:library_app/network/api_constants.dart';
import 'package:library_app/network/responses/search_books_google_response.dart';
import 'package:retrofit/http.dart';

part 'google_api.g.dart';
@RestApi(baseUrl: GOOGLE_BOOK_API_URL)
abstract class GoogleAPI{
  factory GoogleAPI(Dio dio) = _GoogleAPI;

  @GET(GOOGLE_SEARCH_ENDPOINT)
  Future<SearchBooksGoogleResponse> getResultFromGoogle(
      @Query("q") String keyword
      );


}