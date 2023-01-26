import 'package:flutter/material.dart';
import 'package:library_app/blocs/library_page_bloc.dart';
import 'package:library_app/common_widgets/library_collection_view_and_options_widget.dart';
import 'package:library_app/common_widgets/top_search_bar.dart';
import 'package:library_app/pages/create_new_shelf_page.dart';
import 'package:library_app/pages/shelf_detail_page.dart';
import 'package:library_app/resource/enums.dart';
import 'package:provider/provider.dart';

import '../common_widgets/bottom_navigation_bar.dart';
import '../data.vo/book_vo.dart';
import '../data.vo/shelf_vo.dart';
import '../network/api_constants.dart';
import '../resource/dimen.dart';
import '../viewitems/shelf_collection_view_item.dart';

class LibraryPage extends StatefulWidget {
  bool isYourBookPage = true;
  String shlefName = "";

  LibraryPage([String? shelfName]) {
    this.shlefName = shelfName ?? "";
  }

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: LibraryPageBloc(widget.shlefName),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    SafeArea(child: Container()),
                    TopSearchBar(),
                    SizedBox(
                      height: MARGIN_MEDIUM_2,
                    ),
                    TabBarView(
                        tabItems: ["Your books", "Your shelves"],
                        onTapCallback: () {
                          setState(() {
                            widget.isYourBookPage = !widget.isYourBookPage;
                          });
                        }),
                  ],
                ),

                /// if empty show EmptyShelfView else show shelfCollectionView
                // EmptyShelfView()
                // ShelfCollectionView()
                viewToReturn(this.context),
              ],
            ),
          ),
        ),
        floatingActionButton: Visibility(
          visible: widget.isYourBookPage == true ? false : true,
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width * 0.4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(BORDER_RADIUS_MEDIUM),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreateNewShelfPage("", isCreateNewShelf: true)),
                  );
                },
                icon: Icon(Icons.create),
                label: GestureDetector(
                  child: Text("Create New"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CreateNewShelfPage("", isCreateNewShelf: true)),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomNavigationBarWidget(
          Key("libraryButtonNavigationKey"),
          currentPageIndex: 1,
        ),
      ),
    );
  }

  Widget viewToReturn(BuildContext context) {
    if (widget.isYourBookPage == true) {
      return Consumer<LibraryPageBloc>(
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
                  bloc.removeBookFromCurrentList(isbn);
                },
              ));

      // builder: (context,books,child)=> LibraryCollectionViewAndOptionsWidget(
      //   bookList: books, shelfTitle: '', viewOnTapAction: (viewStyle ) {
      //     print("View Style Value :: $viewStyle");
      //     var provider = Provider.of<LibraryPageBloc>(context,listen:false);
      //     provider.setViewStyle(viewStyle);
      //
      //     print("View from bloc ${provider.view}");
      // },
      // ),

    } else {
      return Consumer<LibraryPageBloc>(
        builder: (context, bloc, child) {
          if (bloc.shelfList.isEmpty) {
            return EmptyShelfView();
          } else {
            return ShelfCollectionView(
              shelfList: bloc.shelfList,
            );
          }
        },
      );
    }
  }
}

class ShelfCollectionView extends StatelessWidget {
  final List<ShelfVO> shelfList;

  ShelfCollectionView({required this.shelfList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: ListView.builder(
          itemCount: shelfList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              /// insert a new key here to solve
              key: Key("shelfCollectionViewItemKey"),
              child: ShelfCollectionViewItem(
                isAddToShelvesPage: false,
                shelfName: shelfList[index].shelfName ?? "",
                bookCount: shelfList[index].bookList.length,
                stackBookCoverPath: shelfList[index].bookList.isEmpty == true
                    ? PLACEHOLDER_IMAGE_PATH
                    : '${shelfList[index].bookList.last.bookImage}',
                stackBookCoverPath2: shelfList[index].bookList.isEmpty == true
                    ? PLACEHOLDER_IMAGE_PATH
                    : '${shelfList[index].bookList.first.bookImage}',
                onTapAction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShelfDetailPage(
                              shelfTitle: shelfList[index]?.shelfName ?? "",
                              bookCount: shelfList[index].bookList.length,
                              shelfIndex: index,
                            )),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShelfDetailPage(
                            shelfTitle: shelfList[index]?.shelfName ?? "",
                            bookCount: shelfList[index].bookList.length,
                            shelfIndex: index,
                          )),
                );
              },
            );
          }),
    );
  }
}

class EmptyShelfView extends StatelessWidget {
  const EmptyShelfView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      width: MediaQuery.of(context).size.width * 0.55,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset("assets/icons/binder.png"),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            Text(
              "No shelves",
              style: TextStyle(
                fontSize: FONT_HEADING_1X,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            Text(
              "Create Shelves to match the way you think",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}

class TabBarView extends StatefulWidget {
  TabBarView({required this.tabItems, required this.onTapCallback});

  Function onTapCallback;
  final List<String> tabItems;

  @override
  State<TabBarView> createState() => _TabBarViewState();
}

class _TabBarViewState extends State<TabBarView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key("shelfAndBookTabKey"),
      child: Column(children: [
        Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(BORDER_RADIUS_SMALL)),
          child: DefaultTabController(
            length: widget.tabItems.length,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.all(MARGIN_SMALL),
              child: TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  onTap: (int index) {
                    setState(() {
                      // HomePage.choice == Choice.EBOOK ? (HomePage.choice == Choice.AUDIOBOOK):(HomePage.choice == Choice.EBOOK);
                      widget.onTapCallback();
                    });
                  },
                  isScrollable: true,
                  tabs: widget.tabItems
                      .map(
                        (items) => Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Tab(
                            child: Text(items),
                          ),
                        ),
                      )
                      .toList()),
            ),
          ),
        ),
      ]),
      onTap: () {
        setState(() {
          // HomePage.choice == Choice.EBOOK ? (HomePage.choice == Choice.AUDIOBOOK):(HomePage.choice == Choice.EBOOK);
          widget.onTapCallback();
        });
      },
    );
  }
}

enum LibraryPageTabChoice { BOOK, SHELF }
