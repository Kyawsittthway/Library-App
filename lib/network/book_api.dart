import 'package:dio/dio.dart';
import 'package:library_app/network/api_constants.dart';
import 'package:library_app/network/responses/get_book_categories_response.dart';
import 'package:library_app/network/responses/get_books_by_list_name_response.dart';
import 'package:retrofit/retrofit.dart';

part 'book_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class BookAPI {
  factory BookAPI(Dio dio) = _BookAPI;

  @GET(OVERVIEW_ENDPOINT)
  Future<GetBookCategoriesResponse> getBookCategories(@Query("api-key") String apiKey);

  @GET(LIST_ENDPOINT)
  Future<GetBooksByListNameResponse> getBooksByCategory(
    @Query("api-key") String apiKey,
    @Query("list") String listName,
  );

// @GET(ENDPOINT_GET_TOP_RATED)
// Future<MovieListResponse> getTopRatedMovies(
//     @Query(PARAM_API_KEY) String apiKey,
//     @Query(PARAM_LANGUAGE) String language,
//     @Query(PARAM_PAGE) String page,
//     );

}
