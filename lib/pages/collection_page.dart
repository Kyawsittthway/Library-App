import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_app/blocs/collection_page_bloc.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/resource/dimen.dart';
import 'package:library_app/viewitems/audio_book_view.dart';
import 'package:library_app/viewitems/collection_page_ebook_view.dart';
import 'package:library_app/viewitems/ebook_view.dart';
import 'package:provider/provider.dart';

import '../data.vo/book_vo.dart';
import '../data.vo/books_by_list_name_result_vo.dart';

class CollectionPage extends StatelessWidget {
  final String title;
  final bool isAudio;
  final List<BookVO> bookLists;
  CollectionPage({required this.title,required this.isAudio,required this.bookLists});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>CollectionPageBloc(title),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.grey,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(title,style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: FONT_REGULAR_3X,
            color: Colors.black
          ),),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              Container(
                    margin: EdgeInsets.only(left: MARGIN_MEDIUM,right: MARGIN_MEDIUM, top: MARGIN_MEDIUM),
                    height: MediaQuery.of(context).size.height*0.85,
                    child: GridView.builder(
                      shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          childAspectRatio: isAudio == true ?
                          (MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.8)):
                          (MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.2)),
                        ),
                        itemCount: bookLists.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: isAudio == true ? AudioBookView(): CollectionPageEbookView(imagePath: '${bookLists[index]?.bookImage}', author: '${bookLists[index]?.authorName}', title: '${bookLists[index]?.bookTitle}',),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  BookDetailPage(
                                  bookInfo: bookLists[index],

                                )),
                              );
                            },
                          );
                        }),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
