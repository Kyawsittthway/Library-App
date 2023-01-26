import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_app/data.vo/book_vo.dart';
import 'package:library_app/pages/add_to_shelves_page.dart';
import 'package:library_app/resource/dimen.dart';
import 'package:provider/provider.dart';

import '../blocs/shelf_detail_page_bloc.dart';
import '../pages/home_page.dart';

class LibraryBottomSheetView extends StatelessWidget {
  final BookVO bookInfo;
  final String isbn;
  final String shelfTitle;
  final Function(String) removeBookAction;

  LibraryBottomSheetView(
      {required this.bookInfo,
      required this.isbn,
      required this.shelfTitle,
      required this.removeBookAction});

  List<String> bottomSheetOptions = [
    "Remove Download",
    "Delete from your library",
    "Add to wishlist...",
    "Add to shelves...",
    "About this book"
  ];

  @override
  Widget build(BuildContext context) {
    print("ISBN TO BE INSERTED :: $isbn");
    return ChangeNotifierProvider(
      create: (context) => ShelfDetailPageBloc(shelfTitle),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  padding: EdgeInsets.all(MARGIN_MEDIUM),
                  child: Image.network(
                    bookInfo.bookImage ??
                        "https://i.pinimg.com/originals/e8/ab/83/e8ab83923295950ea0456f39aed9f5f6.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: MARGIN_MEDIUM_2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      key: Key("libraryButtonSheetDismissKey"),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Text(
                          "${bookInfo.bookTitle}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: LARGE_FONT_SIZE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    Text("${bookInfo.authorName}. Ebook"),
                  ],
                )
              ],
            ),
            Divider(
              height: 0.5,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.34,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: bottomSheetOptions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BottomSheetOptionsListView(
                        options: bottomSheetOptions,
                        index: index,
                        respectiveFunction: () {
                          if (index == 1) {
                            // ShelfDetailPageBloc bloc = Provider.of<ShelfDetailPageBloc>(context,listen: false);
                            // bloc.removeBook(isbn, shelfTitle);
                            // Navigator.pop(context);
                            removeBookAction(bookInfo.isbn13 ?? "");
                            Navigator.pop(context);
                          }
                          if (index == 3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddToShelvesPage(
                                        book: bookInfo,
                                      )),
                            );
                          }
                        });
                  }),
            ),
          ],
        ),
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
    Icon(Icons.remove_circle_outline),
    Icon(Icons.delete),
    Icon(Icons.add_circle_outline_outlined),
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
            Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                // Image.network("${options[index].iconPath}",color: Colors.white,),
                iconList[index],
                SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                  child: Text(options[index] ?? ""),
                  onTap: () {
                    respectiveFunction();
                  },
                )
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white,
            )
          ],
        ),
      ),
      onTap: () {
        respectiveFunction();
      },
    );
  }
}
