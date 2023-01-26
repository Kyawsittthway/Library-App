import 'package:flutter/material.dart';

import '../data.vo/book_vo.dart';
import 'bottom_sheet_view.dart';

class EbookView extends StatelessWidget {
 final BookVO bookInfo;

  EbookView({required this.bookInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 150,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    height: 200,
                    child: Image.network(bookInfo.bookImage ?? "https://i.pinimg.com/originals/e8/ab/83/e8ab83923295950ea0456f39aed9f5f6.jpg", fit: BoxFit.cover),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.more_horiz, color: Colors.white,),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.45,
                              child: BottomSheetView(
                             book: bookInfo,
                              ),
                            );
                          });
                    },),
                )
              ],
            ),
          ),
          Container(
            width: 140,
            child: Text(
              "${bookInfo.bookTitle}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Container(
            width: 140,
            child: Text(
              "${bookInfo.authorName}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}
