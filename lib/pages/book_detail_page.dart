import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:library_app/blocs/book_detail_page_bloc.dart';
import 'package:library_app/common_widgets/tappable_header_widget.dart';
import 'package:library_app/pages/about_this_page.dart';
import 'package:library_app/pages/rating_and_review_page.dart';
import 'package:library_app/viewitems/review_comment_section_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../common_widgets/review_comment_widget.dart';
import '../data.vo/book_vo.dart';
import '../resource/dimen.dart';
import '../viewitems/rating_stars_and_bars_view.dart';

class BookDetailPage extends StatelessWidget {
  final BookVO? bookInfo;

  BookDetailPage({required this.bookInfo});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookDetailPageBloc(bookInfo),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            key: Key('backButton'),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Icon(CupertinoIcons.share, color: Colors.grey),
          ],
        ),
        body: Selector<BookDetailPageBloc, BookVO?>(
          selector: (context, bloc) => bloc.book,
          builder: (context, bookInfo, child) => SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AboutBookSection(
                    title: bookInfo?.bookTitle,
                    image: bookInfo?.bookImage,
                    author: bookInfo?.authorName,
                  ),
                  SizedBox(
                    height: MARGIN_MEDIUM_2,
                  ),
                  Divider(
                    height: 0.5,
                    color: Colors.grey,
                    thickness: 0.2,
                  ),
                  SizedBox(
                    height: MARGIN_MEDIUM_2,
                  ),
                  ButtonsSection(),
                  SizedBox(height: MARGIN_MEDIUM_2),
                  AboutThisSection(
                    description: bookInfo?.description,
                    title: bookInfo?.bookTitle,
                  ),
                  SizedBox(height: MARGIN_MEDIUM_2),
                  RatingSection(),
                  SizedBox(
                    height: MARGIN_MEDIUM_2,
                  ),
                  ReviewCommentsSectionView(),
                  SizedBox(
                    height: MARGIN_MEDIUM_2,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Published",
                          style: TextStyle(
                            fontSize: FONT_REGULAR_2X,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: MARGIN_MEDIUM_2,
                        ),
                        Text(
                          "December 1, 2007 . Open Read",
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RatingSection extends StatelessWidget {
  const RatingSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TappableHeaderWidget(
              title: "Rating and reviews",
              isAudio: false,
              onTapAction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RatingAndReviewPage()),
                );
              }),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
              child: RatingStarAndBarView()),
        ],
      ),
    );
  }
}

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FreeSampleButton(),
              SizedBox(
                width: MARGIN_MEDIUM,
              ),
              AddToWishlistButton(),
            ],
          ),
          SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          NoticeTextView(),
        ],
      ),
    );
  }
}

class AboutThisSection extends StatelessWidget {
  final String? title;
  final String? description;

  AboutThisSection({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TappableHeaderWidget(
              title: "About this ebook",
              isAudio: false,
              onTapAction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AboutThisPage(
                            bookTitle: '${title}',
                            bookDescription: '${description}',
                          )),
                );
              }),
          Container(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
            child: Text(
              "${description}",
              textAlign: TextAlign.start,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black45, fontSize: SMALL_FONT_SIZE_14),
            ),
          )
        ],
      ),
    );
  }
}

class NoticeTextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Colors.black45,
          ),
          SizedBox(
            width: MARGIN_SMALL,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Text(
              "Books that you buy on the Google Play website can be read in this app",
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AddToWishlistButton extends StatelessWidget {
  const AddToWishlistButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 40,
      child: ElevatedButton.icon(
        onPressed: () {},
        label: Text("Add to wishlist"),
        style: ElevatedButton.styleFrom(),
        icon: Icon(CupertinoIcons.add_circled),
      ),
    );
  }
}

class FreeSampleButton extends StatelessWidget {
  const FreeSampleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "Free Sample",
          style: TextStyle(color: Colors.blue),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
        ),
      ),
    );
  }
}

class AboutBookSection extends StatelessWidget {
  final String? image;
  final String? title;
  final String? author;

  AboutBookSection(
      {required this.image, required this.title, required this.author});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          padding: EdgeInsets.all(MARGIN_MEDIUM),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: 135,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(BORDER_RADIUS_SMALL),
                  child: Image.network(
                    "$image",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: MARGIN_MEDIUM_2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    child: Text(
                      "$title",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: FONT_REGULAR_3X,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.58,
                  ),
                  SizedBox(
                    height: MARGIN_SMALL,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.58,
                      child: Text(
                        "$author",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  SizedBox(
                    height: MARGIN_SMALL,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.58,
                      child: Text(
                        "Ebook . 187 pages",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
