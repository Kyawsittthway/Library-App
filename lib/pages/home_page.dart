import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:library_app/common_widgets/bottom_navigation_bar.dart';
import 'package:library_app/data.vo/models/book_model.dart';
import 'package:library_app/data.vo/models/book_model_impl.dart';
import 'package:library_app/network/api_constants.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:library_app/pages/collection_page.dart';
import 'package:library_app/pages/library_page.dart';
import 'package:library_app/resource/dimen.dart';
import 'package:library_app/viewitems/audio_book_view.dart';
import 'package:library_app/viewitems/bottom_sheet_view.dart';
import 'package:library_app/viewitems/current_list_book_view.dart';
import 'package:library_app/viewitems/ebook_view.dart';
import 'package:provider/provider.dart';

import '../blocs/home_bloc.dart';
import '../common_widgets/tappable_header_widget.dart';
import '../common_widgets/top_search_bar.dart';
import '../data.vo/book_vo.dart';
import '../data.vo/list_vo.dart';

enum Choice { EBOOK, AUDIOBOOK }

class HomePage extends StatefulWidget {
  Choice choice = Choice.EBOOK;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> tabItems = ["Ebooks", "Audiobooks"];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value:HomeBloc(),
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                    child: Container(
                  height: 0,
                )),
                TopSearchBar(),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Selector<HomeBloc,List<BookVO>>(
                  selector: (context,bloc)=> bloc.currentBookList,
                    builder: (context,bookList,child)=> CurrentListView(books: bookList,)
                ),
                TabBarView(
                  tabItems: tabItems,
                  onTapCallback: () {
                    setState(() {
                      widget.choice == Choice.EBOOK
                          ? (widget.choice = Choice.AUDIOBOOK)
                          : (widget.choice = Choice.EBOOK);
                    });
                  },
                ),
                SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Container(
                  child: widget.choice == Choice.EBOOK
                      ? Selector<HomeBloc, List<ListVO>>(
                          selector: (context, bloc) => bloc.categoryLists,
                          builder: (context, categoryLists, child) =>
                              EbookViews(lists: categoryLists),
                        )
                      : AudioBookViews(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          Key("bottomNavigationbarKey"),
          currentPageIndex: 0,
        ),
      ),
    );
  }
}

class EbookViews extends StatelessWidget {
  final List<ListVO> lists;

  EbookViews({required this.lists});

  @override
  Widget build(BuildContext context) {

    return Container(

      child: ListView.builder(
          itemCount: lists.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return EbookHomePageCollectionView(
              title: lists[index].listName ?? "",
              books: lists[index].bookList ?? [],
            );
          }),
    );
  }
}

class AudioBookViews extends StatelessWidget {
  const AudioBookViews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AudioBookCollectionView(
          title: "More Like Sapien",
          isAudio: true,
        ),
        AudioBookCollectionView(
          title: "More Like Sapien",
          isAudio: true,
        ),
        AudioBookCollectionView(
          title: "On your wishlist",
          isAudio: true,
        ),
      ],
    );
  }
}

class EbookHomePageCollectionView extends StatelessWidget {
  final String title;
  final List<BookVO> books;

  EbookHomePageCollectionView({required this.title, required this.books});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TappableHeaderWidget(
            title: title,
            isAudio: false,
            onTapAction: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CollectionPage(
                          title: title,
                          isAudio: false,
                          bookLists: books,
                        )),
              );
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(MARGIN_MEDIUM),
                  child: GestureDetector(
                    child: EbookView(
                    bookInfo: books[index],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailPage(
                            bookInfo: books[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              itemCount: books.length > 10 ? 10 : books.length,
            ),
          )
        ],
      ),
    );
  }
}

class AudioBookCollectionView extends StatelessWidget {
  final String title;
  final bool isAudio;

  AudioBookCollectionView({required this.title, required this.isAudio});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TappableHeaderWidget(
            title: title,
            isAudio: isAudio,
            onTapAction: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CollectionPage(
                          title: title,
                          isAudio: isAudio,
                          bookLists: [],
                        )),
              );
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(MARGIN_SMALL),
                  child: GestureDetector(
                    child: AudioBookView(),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.45,
                              child: Container(),
                              // child: BottomSheetView(
                              //   book:BookVO(
                              //
                              //   )
                              // ),
                            );
                          });
                    },
                  ),
                );
              },
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}

class CurrentListView extends StatelessWidget {

  final List<BookVO> books;
  CurrentListView({
    required this.books
});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        options: CarouselOptions(
            height: 400,
            aspectRatio: 1.4,
            viewportFraction: 0.7,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            autoPlay: false,
            onPageChanged: (index, reason) {}),
        items: books.map((e) => CurrentListBookView(imagePath: e.bookImage ?? "")).toList(),
      ),
    );
  }

  // List<Widget> _createPageChilds() {
  //   List<Widget> widgets = [
  //     CurrentListBookView(),
  //     CurrentListBookView(),
  //     CurrentListBookView(),
  //   ];
  //   return widgets;
  // }
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
    return Column(children: [
      Container(
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(BORDER_RADIUS_SMALL)),
        child: DefaultTabController(
          length: widget.tabItems.length,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.all(MARGIN_SMALL),
            child: TabBar(
                labelColor: Colors.grey,
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
                        width: 100,
                        child: Tab(
                          child: Text(items),
                        ),
                      ),
                    )
                    .toList()),
          ),
        ),
      ),
    ]);
  }
}
