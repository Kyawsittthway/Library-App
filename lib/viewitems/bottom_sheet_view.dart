import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_app/resource/dimen.dart';

import '../data.vo/book_vo.dart';
import '../pages/add_to_shelves_page.dart';

class BottomSheetView extends StatelessWidget {
  final BookVO book;

  BottomSheetView({required this.book});

  List<String> bottomSheetOptions = [
    "Download",
    "Delete from your library",
    "Add to shelves...",
    "Mark as read"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                padding: EdgeInsets.all(MARGIN_MEDIUM),
                child: Image.network("${book.bookImage}",fit: BoxFit.fill,),
              ),
              SizedBox(width: MARGIN_MEDIUM_2,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: Text("${book.bookTitle}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                      fontSize: LARGE_FONT_SIZE,
                      fontWeight: FontWeight.w600,
                    ),),
                  ),
                  SizedBox(height: MARGIN_SMALL,),
                  Text("${book.authorName}. Ebook"),
                ],
              )
            ],
          ),
          Divider(height: 0.5,),
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: bottomSheetOptions.length,
                itemBuilder: (BuildContext context,int index){
              return BottomSheetOptionsListView(options: bottomSheetOptions, index: index, respectiveFunction: (){
                if(index == 2 ){

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  AddToShelvesPage(book:book,)),
                  );

                }
              });
            }),
          )
        ],
      ),
    );
  }
}
class BottomSheetOptionsListView extends StatelessWidget {
  BottomSheetOptionsListView({
    required this.options,
    required this.index,
    required this.respectiveFunction,
  });
  final List<String> options;
  int index;
  final Function respectiveFunction;
  List<Icon> iconList = [
    Icon(Icons.download_rounded),
    Icon(Icons.delete),
    Icon(Icons.add),
    Icon(Icons.check)
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          // border: Border.all(color:PAYMENT_CONTAINER_BORDER),
          // borderRadius: BorderRadius.circular(BORDER_RADIUS_NORMAL),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              SizedBox(width: 10.0,),
              // Image.network("${options[index].iconPath}",color: Colors.white,),
              iconList[index],
              SizedBox(width: 5.0,),
              Text(options?[index] ?? "")
            ],),
            Icon(Icons.chevron_right,color: Colors.white,)


          ],
        ),
      ),
      onTap: (){
        respectiveFunction();
      },
    );
  }
}