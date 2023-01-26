import 'package:flutter/material.dart';
import 'package:library_app/resource/dimen.dart';

class AboutThisPage extends StatelessWidget {
  final String? bookTitle;
  final String? bookDescription;
  AboutThisPage({required this.bookTitle,required this.bookDescription});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("${bookTitle}",style: TextStyle(
          color:Colors.black
        ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color:Colors.grey),
          onPressed: (){
             Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MARGIN_MEDIUM_2),
          child: Text(
              "${bookDescription}",
      style: TextStyle(
              fontSize: SMALL_FONT_SIZE_14,
          ),
          ),
        ),
      ),

    );
  }
}
