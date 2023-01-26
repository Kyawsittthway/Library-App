import 'package:flutter/material.dart';
import 'package:library_app/data.vo/google_book_vo.dart';
import 'package:library_app/data.vo/models/google_model.dart';
import 'package:library_app/data.vo/models/google_model_impl.dart';

class SearchPageBloc extends ChangeNotifier{
  List<GoogleBookVO> bookList = [];

  GoogleModel mGoogleModel = GoogleModelImpl();


  SearchPageBloc(){

  }

  void getSearchResult(String key){
    mGoogleModel.getResultFromGoogle(key).then((results){
      bookList = results;
      notifyListeners();
      print(bookList);
      print( " imagePath sample :: ${bookList.first.volumeInfoVO?.imageLinks?.imagePath}");
    }).catchError((error){
      print("error finding books from google :: $error");
    });
  }
}