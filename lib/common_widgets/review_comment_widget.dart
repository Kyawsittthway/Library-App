import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../resource/dimen.dart';

class ReviewCommentWidget extends StatelessWidget {
  final String reviewerImagePath;
  final double reviewerRating;
  final String reviewerName;
  final String date;
  final String reviewContent;

  ReviewCommentWidget(
      {required this.reviewerImagePath,
        required this.reviewerRating,
        required this.reviewerName,
        required this.date,
        required this.reviewContent});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top:MARGIN_MEDIUM_2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  reviewerImagePath,
                  // "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Aaron_Paul_by_Gage_Skidmore_3.jpg/440px-Aaron_Paul_by_Gage_Skidmore_3.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: MARGIN_MEDIUM_2,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reviewerName),
                  Row(
                    children: [
                      RatingBar.builder(
                          initialRating: reviewerRating,
                          itemSize: 20,
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Colors.blue),
                          onRatingUpdate: (rating) {
                            print(rating);
                          }),
                      SizedBox(
                        width: MARGIN_SMALL,
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: NORMAL_FONT_SIZE,
                          color: Colors.black45,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MARGIN_MEDIUM_2,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.78,
                    child: Text(
                      // "F CATS DISAPPEARED FROM THE WORLD is a beautiful, comforting story despite the grisly premise. It's about a young man's journey towards accepting the end and making peace with it. And it's about cats. I'd recommend if you love cats, Japanese fiction or speculative writings about life and death",
                      reviewContent,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}