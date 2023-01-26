import 'package:flutter/material.dart';
import 'package:library_app/blocs/library_page_bloc.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/viewitems/library_bottom_sheet_view.dart';
import 'package:library_app/viewitems/sort_by_bottom_sheet_view.dart';
import 'package:library_app/viewitems/view_as_button_sheet_view.dart';
import 'package:provider/provider.dart';

import '../data.vo/book_vo.dart';
import '../resource/dimen.dart';
import '../resource/enums.dart';
import '../viewitems/library_list_view_item.dart';
import '../viewitems/shelf_detail_book_item_view.dart';

class LibraryCollectionViewAndOptionsWidget extends StatelessWidget {
  final List<BookVO> bookList;
  final String shelfTitle;
  final ViewStyle viewChoice;
  final SortStyle sortingChoice;
  final List<String> categoryLists;
  final bool isShelfDetail;
  int? selectedIndex;

  final Function(ViewStyle) viewOnTapAction;
  final Function(SortStyle) sortingOnTapAction;
  final Function(int) filterOnTapAction;
  final Function filterClearAction;
  final Function(String) removeBookAction;

  LibraryCollectionViewAndOptionsWidget(
      {required this.bookList,
      required this.shelfTitle,
      required this.viewOnTapAction,
      required this.sortingOnTapAction,
      required this.viewChoice,
      required this.sortingChoice,
      required this.categoryLists,
      required this.filterOnTapAction,
      required this.selectedIndex,
      required this.filterClearAction,
      required this.isShelfDetail,
      required this.removeBookAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: FilterButtonsSection(
            isShelfDetail: isShelfDetail,
            categoryTitles: categoryLists,
            onTapAction: (index) {
              filterOnTapAction(index);
            },
            selectedIndex: selectedIndex,
            clearFilterAction: () {
              filterClearAction();
            },
          ),
        ),
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Column(
            children: [
              SortingOptionsButtonView(

                onTapActionView: (ViewStyle) {
                  viewOnTapAction(ViewStyle);
                },
                style: viewChoice,
                sorting: sortingChoice,
                onTapActionSorting: (SortStyle) {
                  sortingOnTapAction(SortStyle);
                },
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),

              ViewToReturn(viewChoice ?? ViewStyle.ListView, context)

              ///Grid View
              // Container(
              //
              //   child: GridView.builder(
              //     itemCount: 10,
              //     shrinkWrap: true,
              //     physics:NeverScrollableScrollPhysics(),
              //     itemBuilder: (BuildContext context, int index) {
              //       return GestureDetector(
              //           child: ShelfDetailBookItemView(isLargeGrid: true), onTap: () {});
              //     },
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       childAspectRatio: (MediaQuery.of(context).size.width /
              //           (MediaQuery.of(context).size.height / 1.2)),
              //       crossAxisSpacing: 10,
              //     ),
              //   ),
              // ),
              //
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.85,
              //   child: GridView.builder(
              //     itemCount: 10,
              //     shrinkWrap: true,
              //     itemBuilder: (BuildContext context, int index) {
              //       return GestureDetector(
              //           child: ShelfDetailBookItemView(isLargeGrid: false,), onTap: () {});
              //     },
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 3,
              //       childAspectRatio: (MediaQuery.of(context).size.width /
              //           (MediaQuery.of(context).size.height / 1.1)),
              //       crossAxisSpacing: 10,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }

  Widget ViewToReturn(ViewStyle view, BuildContext context) {
    print("View To Return value :: $view");
    print("View To Return called");
    if (view == null || view == ViewStyle.ListView) {
      return Container(
        child: ListView.builder(
            itemCount: bookList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return LibraryListViewItem(
                onTapAction: (index) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailPage(
                        bookInfo: bookList[index],
                      ),
                    ),
                  );
                },
                bookInfo: bookList[index],
                shelfTitle: shelfTitle,
                index: index,
                removeBook: (isbn) {
                  removeBookAction(isbn);
                },
              );
            }),
      );
    } else if (view == ViewStyle.SmallGrid) {
      return Container(
        child: GridView.builder(
          itemCount: bookList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                child: ShelfDetailBookItemView(
                  isLargeGrid: true,
                  bookInfo: bookList[index],
                  removeBook: (isbn) {
                    removeBookAction(isbn);
                  },
                ),
                onTap: () {

                });
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.2)),
            crossAxisSpacing: 10,
          ),
        ),
      );
    } else {
      print("Large grid?");
      return Container(
        height: MediaQuery.of(context).size.height * 0.85,
        child: GridView.builder(
          itemCount: bookList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                child: ShelfDetailBookItemView(
                  bookInfo: bookList[index],
                  isLargeGrid: false,
                  removeBook: (isbn) {
                    removeBookAction(isbn);
                  },
                ),
                onTap: () {});
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: (MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.1)),
            crossAxisSpacing: 10,
          ),
        ),
      );
    }
  }
}

class FilterButtonsSection extends StatelessWidget {
  final bool isShelfDetail;
  final List<String> categoryTitles;
  final Function(int) onTapAction;
  final Function clearFilterAction;
  int? selectedIndex;

  FilterButtonsSection(
      {required this.isShelfDetail,
      required this.categoryTitles,
      required this.onTapAction,
      required this.selectedIndex,
      required this.clearFilterAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: isShelfDetail == true ? 200 : double.infinity,
      decoration: isShelfDetail == true
          ? BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(BORDER_RADIUS_MEDIUM))
          : null,
      child: isShelfDetail == true
          ? Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Container(
                    child: Text(
                      "Not started",
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w400),
                    ),
                  ),
                  onTap: () {},
                ),
                VerticalDivider(
                  width: 1.5,
                  color: Colors.grey,
                  thickness: 2,
                  indent: 5.0,
                  endIndent: 5.0,
                ),
                GestureDetector(
                  child: Container(
                    child: Text(
                      "In progress",
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w400),
                    ),
                  ),
                  onTap: () {},
                )
              ],
            )
          : Row(mainAxisSize: MainAxisSize.max, children: [
              Visibility(
                  visible: selectedIndex == null ? false : true,
                  child: IconButton(
                      key: Key("clearFilterKey"),
                      onPressed: () {
                        clearFilterAction();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.blue,
                      ))),
              Expanded(
                child: Container(
                  key: Key("filterSectionKey"),
                  width: MediaQuery.of(context).size.width * 0.87,
                  child: ListView.builder(
                      itemCount: categoryTitles.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          child: Container(
                            width: 150,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.circular(BORDER_RADIUS_MEDIUM),
                                color: index == selectedIndex
                                    ? Colors.blue
                                    : Colors.white),
                            child: Center(
                              child: GestureDetector(
                                child: Text(
                                  categoryTitles[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w400),
                                ),
                                onTap: (){
                                  onTapAction(index);
                                },
                              ),
                            ),
                          ),
                          onTap: () {
                            print(index);
                            print(categoryTitles[index]);
                            onTapAction(index);
                          },
                        );
                      }),
                ),
              ),
            ]),
    );
  }
}

class SortingOptionsButtonView extends StatelessWidget {
  final Function(ViewStyle) onTapActionView;
  final Function(SortStyle) onTapActionSorting;
  final ViewStyle style;
  final SortStyle sorting;
  SortingOptionsButtonView(

      {required this.style,
      required this.onTapActionView,
      required this.onTapActionSorting,
      required this.sorting});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          key: Key("SortingOptionsButtonViewKey"),
          child: Row(
            children: [
              Icon(Icons.sort),
              SizedBox(
                width: MARGIN_SMALL,
              ),

              /// put sorting style name at the place of recent
              Container(
                child: Text("Sorted by : ${sorting.name}"),
              ),
            ],
          ),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: SortByBottomSheetView(
                      choice: sorting,
                      onTapAction: (value) {
                        onTapActionSorting(value);
                      },
                    ),
                  );
                });
          },
        ),
        IconButton(
          key: Key("ViewAsOptionKey"),
          icon: Icon(Icons.menu),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ViewAsBottomSheetView(
                        onTapAction: (value) {
                          onTapActionView(value);
                        },
                        choice: style,
                      ));
                });
          },
        )
      ],
    ));
  }
}
