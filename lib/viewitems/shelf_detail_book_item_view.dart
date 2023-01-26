import 'package:flutter/material.dart';
import 'package:library_app/viewitems/library_bottom_sheet_view.dart';

import '../data.vo/book_vo.dart';
import '../resource/dimen.dart';

class ShelfDetailBookItemView extends StatelessWidget {
  final bool isLargeGrid;
  final BookVO bookInfo;
  final Function(String) removeBook;
  ShelfDetailBookItemView({
    required this.isLargeGrid,
    required this.bookInfo,
    required this.removeBook
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: isLargeGrid == true ? 280 : 180,
            // width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(BORDER_RADIUS_SMALL),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(BORDER_RADIUS_SMALL),
                    child: Image.network(
                      "${bookInfo.bookImage}",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    child: IconButton(
                      icon: Icon(Icons.more_horiz, color: Colors.white,),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context, builder: (BuildContext context) {
                          return LibraryBottomSheetView(
                              bookInfo: bookInfo,
                              isbn: bookInfo.isbn13 ?? "",
                              shelfTitle: "", removeBookAction: (isbn){
                                removeBook(isbn);
                          },);
                        });
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            BORDER_RADIUS_SMALL),
                        color: Colors.black87
                    ),
                    margin: EdgeInsets.only(
                        bottom: MARGIN_SMALL, right: MARGIN_SMALL),
                    child: IconButton(
                      icon: Icon(
                        Icons.check_outlined, color: Colors.white, size: 15,),
                      onPressed: () {

                      },
                    ),
                  ),
                ),


              ],
            ),
          ),
          Container(
            width: 140,
            child: GestureDetector(
              child: Text(
                "${bookInfo.bookTitle}",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              onTap: (){
                showModalBottomSheet(
                    context: context, builder: (BuildContext context) {
                  return LibraryBottomSheetView(
                    bookInfo: bookInfo,
                    isbn: bookInfo.isbn13 ?? "",
                    shelfTitle: "", removeBookAction: (isbn){
                    removeBook(isbn);
                  },);
                });
              },
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
