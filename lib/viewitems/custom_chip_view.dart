import 'package:flutter/material.dart';
import 'package:library_app/resource/dimen.dart';

class CustomChipView extends StatelessWidget {
  CustomChipView(
      {required this.genreList,
      required this.chipHeight,
      required this.chipWidth,
      required this.isCenter});

  final List<String> genreList;
  final double chipHeight;
  final double chipWidth;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: MARGIN_SMALL,
      runSpacing: MARGIN_SMALL,
      children: genreList
          .map((genre) => FilterChipView(
                genre: genre,
                width: chipWidth,
                height: chipHeight,
                isCenter: isCenter,
              ))
          .toList(),
    );
  }
}

class FilterChipView extends StatelessWidget {
  final String genre;
  final double width;
  final double height;
  final bool isCenter;

  FilterChipView(
      {required this.genre,
      required this.width,
      required this.height,
      required this.isCenter});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isCenter == true ? width : null,
      height: isCenter == true ? height : 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isCenter == true
              ? BorderRadius.circular(BORDER_RADIUS_MEDIUM)
              : BorderRadius.circular(BORDER_RADIUS_SMALL),
          boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 1.0)],
        ),
        child: isCenter == true
            ?  Row(
          mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      genre,
                      style: TextStyle(
                        fontSize: NORMAL_FONT_SIZE,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(Icons.star,color: Colors.black54,),
                  ],
                ) : Padding(
                padding: EdgeInsets.symmetric(horizontal: MARGIN_SMALL),
                child: Text(
                  genre,
                  style: TextStyle(
                    fontSize: NORMAL_FONT_SIZE,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
      ),
    );
  }
}
