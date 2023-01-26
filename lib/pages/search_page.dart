import 'package:flutter/material.dart';
import 'package:library_app/blocs/home_bloc.dart';
import 'package:library_app/blocs/search_page_bloc.dart';
import 'package:library_app/data.vo/google_book_vo.dart';
import 'package:library_app/pages/book_detail_page.dart';
import 'package:provider/provider.dart';

import '../resource/dimen.dart';

class SearchPage extends StatefulWidget {
  CurrentChoice choice = CurrentChoice.audiobooks;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchPageBloc(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black87,
                          )),
                      Consumer<SearchPageBloc>(
                        builder: (context, bloc, child) => Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextFormField(
                              onFieldSubmitted: (String value) {
                                SearchPageBloc bloc =
                                    Provider.of<SearchPageBloc>(context,
                                        listen: false);
                                bloc.getSearchResult(value);
                              },
                              decoration: InputDecoration(
                                hintText: "Search Play Books",
                                border: InputBorder.none,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              TabBarView(
                  tabItems: ["Ebooks", "Audiobooks"],
                  onTapCallback: () {
                    if (widget.choice == CurrentChoice.audiobooks) {
                      widget.choice = CurrentChoice.ebooks;
                    } else {
                      widget.choice = CurrentChoice.audiobooks;
                    }
                  }),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              Selector<SearchPageBloc, List<GoogleBookVO>>(
                selector: (context, bloc) => bloc.bookList,
                builder: (context, bookList, child) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: Visibility(
                    visible: bookList.isEmpty ? false : true,
                    child: Text(
                      "Results from Google Play",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: LARGE_FONT_SIZE,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              Selector<SearchPageBloc, List<GoogleBookVO>?>(
                selector: (context, bloc) => bloc.bookList,
                builder: (context, bookList, child) => Container(
                  child: bookList?.isEmpty == true
                      ? Container(
                          child: null,
                        )
                      : ListView.builder(
                          itemCount: bookList?.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(MARGIN_MEDIUM_2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 150,
                                      child: ClipRRect(
                                        child: Image.network(
                                            "${bookList?[index]?.volumeInfoVO?.imageLinks?.imagePath}"),
                                        borderRadius: BorderRadius.circular(
                                            BORDER_RADIUS_SMALL),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MARGIN_MEDIUM_2,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            "${bookList?[index]?.volumeInfoVO?.title}",
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: NORMAL_FONT_SIZE_2X,
                                                fontWeight: FontWeight.w600),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MARGIN_SMALL,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.40,
                                          child: Text(
                                            "${bookList?[index]?.volumeInfoVO?.authors?.join(",")}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MARGIN_SMALL,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.40,
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
                              ),
                              onTap: () {
                                /// will continue after developing a function to convert google book vo to nyt vo
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BookDetailPage(
                                        bookInfo: bookList?[index]?.toBookVO()),
                                  ),
                                );
                              },
                            );
                          }),
                ),
              )
            ],
          ),
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
    return Column(children: [
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
    ]);
  }
}

enum CurrentChoice { ebooks, audiobooks }
