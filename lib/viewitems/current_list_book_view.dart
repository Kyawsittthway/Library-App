import 'package:flutter/material.dart';
import 'package:library_app/resource/dimen.dart';

class CurrentListBookView extends StatelessWidget {
  final String imagePath;

  CurrentListBookView({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MARGIN_MEDIUM_2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BORDER_RADIUS_LARGE)),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(BORDER_RADIUS_LARGE),
              child: Image.network(
                imagePath ?? "https://i.pinimg.com/originals/e8/ab/83/e8ab83923295950ea0456f39aed9f5f6.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              child: IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {},
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
              child: IconButton(
                icon: Icon(Icons.headset),
                onPressed: () {},
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
              child: IconButton(
                icon: Icon(Icons.check_outlined),
                onPressed: () {},
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(MARGIN_SMALL),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_SMALL),
                child: Container(
                  width: 200,
                  child: LinearProgressIndicator(
                    value: 100,
                    backgroundColor: Colors.black45,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
