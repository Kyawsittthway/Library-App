import 'package:flutter/material.dart';
import 'package:library_app/blocs/shelf_detail_page_bloc.dart';
import 'package:library_app/pages/create_new_shelf_page.dart';
import 'package:library_app/pages/library_page.dart';
import 'package:library_app/resource/dimen.dart';
import 'package:library_app/resource/enums.dart';
import 'package:library_app/viewitems/custom_chip_view.dart';
import 'package:library_app/viewitems/library_list_view_item.dart';
import 'package:library_app/viewitems/shelf_detail_book_item_view.dart';
import 'package:library_app/viewitems/shelf_detail_bottom_sheet_view.dart';
import 'package:provider/provider.dart';

import '../common_widgets/library_collection_view_and_options_widget.dart';
import '../data.vo/book_vo.dart';

class ShelfDetailPage extends StatefulWidget {
  final String shelfTitle;
  final int bookCount;
  final int shelfIndex;

  ShelfDetailPage(
      {required this.shelfTitle,
      required this.bookCount,
      required this.shelfIndex});

  @override
  State<ShelfDetailPage> createState() => _ShelfDetailPageState();
}

class _ShelfDetailPageState extends State<ShelfDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ShelfDetailPageBloc(widget.shelfTitle),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Consumer<ShelfDetailPageBloc>(
              builder: (context,bloc,child)=> IconButton(
                  key: Key("ShelfDetailOptionsKey"),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                             return  Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: ShelfDetailBottomSheetView(
                                deleteShelfAction: () {
                                  bloc.removeShelf();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) => LibraryPage()),
                                          (Route<dynamic> route) => route is LibraryPage);
                                },
                                renameAction: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>CreateNewShelfPage(widget.shelfTitle,isCreateNewShelf: false)));

                                }, shelfName:'${bloc.shelf?.shelfName}',
                              ),
                            );

                        });
                  },
                  icon: Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: Column(
                    children: [
                      Consumer<ShelfDetailPageBloc>(
                        builder: (context, bloc, child) =>
                            TitleAndBookCountSection(
                          bookCount: bloc.shelf?.bookList.length ?? 0,
                          title: widget.shelfTitle,
                        ),
                      ),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      Divider(
                        height: 0.5,
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                    ],
                  ),
                ),
                Consumer<ShelfDetailPageBloc>(
                    builder: (context, bloc, child) =>
                        LibraryCollectionViewAndOptionsWidget(
                          bookList: bloc.filteredBookList,
                          shelfTitle: "",
                          viewOnTapAction: (viewStyle) {
                            bloc.view = viewStyle;
                            bloc.notifyListeners();
                            Navigator.pop(context);
                          },
                          viewChoice: bloc.view ?? ViewStyle.LargeGrid,
                          categoryLists: bloc.listTitles,
                          filterOnTapAction: (index) {
                            bloc.filterSelectedIndex = index;
                            bloc.filterCurrentBooks(index);
                            bloc.notifyListeners();
                          },
                          selectedIndex: bloc.filterSelectedIndex,
                          filterClearAction: () {
                            bloc.filterSelectedIndex = null;
                            bloc.filterCurrentBooks(bloc.filterSelectedIndex);
                            bloc.notifyListeners();
                          },
                          sortingOnTapAction: (sortStyle) {
                            bloc.setSortStyle(sortStyle);
                            Navigator.pop(context);
                          },
                          sortingChoice: bloc.sorting ?? SortStyle.Recent,
                          isShelfDetail: false,
                          removeBookAction: (isbn) {
                            bloc.removeBookFromShelf(isbn);
                            // Navigator.pop(context);
                          },
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TitleAndBookCountSection extends StatelessWidget {
  final String title;
  final int bookCount;

  TitleAndBookCountSection({required this.title, required this.bookCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Text(
            "$title",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: FONT_HEADING_1X,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Text(
            "$bookCount books",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: FONT_REGULAR,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}
