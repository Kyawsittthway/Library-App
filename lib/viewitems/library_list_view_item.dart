import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_app/resource/dimen.dart';

import '../data.vo/book_vo.dart';
import 'library_bottom_sheet_view.dart';

class LibraryListViewItem extends StatelessWidget {
  final BookVO bookInfo;
  final String shelfTitle;
  final int index;
  Function(int bookId) onTapAction;
  Function(String) removeBook;

  LibraryListViewItem(
      {required this.index,
      required this.bookInfo,
      required this.onTapAction,
      required this.shelfTitle,
      required this.removeBook});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(BORDER_RADIUS_SMALL),
                      child: Image.network("${bookInfo.bookImage}")),
                ),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: Text(
                        "${bookInfo.bookTitle}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: Text(
                        "${bookInfo.authorName}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: Text(
                        "Ebook.Sample",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              this.onTapAction(index);
            },
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.download_rounded, color: Colors.black87)),
          SizedBox(
            width: MARGIN_MEDIUM,
          ),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return LibraryBottomSheetView(
                        bookInfo: bookInfo,
                        isbn: bookInfo.isbn13 ?? "",
                        shelfTitle: shelfTitle, removeBookAction: (isbn) {
                          removeBook(isbn);
                      },

                      );
                    });
              },
              icon: Icon(Icons.more_horiz, color: Colors.black87))
        ],
      ),
    );
  }
}
