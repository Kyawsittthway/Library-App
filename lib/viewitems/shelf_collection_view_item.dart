import 'package:flutter/material.dart';
import 'package:library_app/network/api_constants.dart';

import '../resource/dimen.dart';

class ShelfCollectionViewItem extends StatelessWidget {
  final bool isAddToShelvesPage;
  final int bookCount;
  final String shelfName;
  final String? stackBookCoverPath;
  final String? stackBookCoverPath2;
  final Function onTapAction;

  ShelfCollectionViewItem({
    required this.isAddToShelvesPage,
    required this.bookCount,
    required this.shelfName,
    required this.onTapAction,
    this.stackBookCoverPath = PLACEHOLDER_IMAGE_PATH,
    this.stackBookCoverPath2 = PLACEHOLDER_IMAGE_PATH,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          StackBooksView(stackBookCoverPath, stackBookCoverPath2),
          ShelfNameAndBookCountSection(
            bookCounts: bookCount,
            shelfName: '$shelfName',
            onTap: (){
              onTapAction();
            },
          ),
          SizedBox(
            width: MARGIN_MEDIUM_2,
          ),
          TailingIcon(
            isAddToShelves: isAddToShelvesPage,
          )
        ],
      ),
    );
  }
}

class TailingIcon extends StatelessWidget {
  final bool isAddToShelves;

  TailingIcon({required this.isAddToShelves});

  @override
  Widget build(BuildContext context) {
    if (isAddToShelves == false) {
      return Container(
          padding: EdgeInsets.only(top: 20),
          child: Icon(Icons.arrow_forward_ios));
    } else {
      return Container(
          padding: EdgeInsets.only(top: 20),
          child: Icon(Icons.check_box_outline_blank));
    }
  }
}

class ShelfNameAndBookCountSection extends StatelessWidget {
  final String shelfName;
  final int bookCounts;
  final Function onTap;
  ShelfNameAndBookCountSection(
      {required this.shelfName, required this.bookCounts,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          child: GestureDetector(
            child: Text(
              "$shelfName",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: (){
              onTap();
            },
          ),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Container(
          width: 200,
          child: Text(
            "$bookCounts books",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: NORMAL_FONT_SIZE,
                color: Colors.black54),
          ),
        )
      ],
    );
  }
}

class StackBooksView extends StatelessWidget {
  final String? imagePath;
  final String? imagePath2;

  StackBooksView(this.imagePath, this.imagePath2);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 10,
            child: Container(
              width: 75,
              height: 85,
              child: Image.network(
                "$imagePath2",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 5,
            child: Container(
              width: 75,
              height: 85,
              child: Image.network(
                "$imagePath",
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }
}
