import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../resource/dimen.dart';
class RatingStarAndBarView extends StatelessWidget {
  const RatingStarAndBarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StarRatingSection(),
        SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        RatingProgressBarsView()
      ],
    );
  }
}

class RatingProgressBarsView extends StatelessWidget {
  const RatingProgressBarsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RatingProgressBar(
            totalPercent: 1.0,
            leadHeading: "5",
          ),
          SizedBox(
            height: 3,
          ),
          RatingProgressBar(
            totalPercent: 0.75,
            leadHeading: "4",
          ),
          SizedBox(
            height: 3,
          ),
          RatingProgressBar(
            totalPercent: 0.3,
            leadHeading: "3",
          ),
          SizedBox(
            height: 3,
          ),
          RatingProgressBar(
            totalPercent: 0.45,
            leadHeading: "2",
          ),
          SizedBox(
            height: 3,
          ),
          RatingProgressBar(
            totalPercent: 0.2,
            leadHeading: "1",
          ),
        ],
      ),
    );
  }
}
class StarRatingSection extends StatelessWidget {
  const StarRatingSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "3.9",
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w600,
            ),
          ),
          RatingBar.builder(
              itemSize: 35,
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.blue),
              onRatingUpdate: (rating) {
                print(rating);
              }),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Container(
            child: Text(
              "95 ratings",
              style: TextStyle(color: Colors.black45),
            ),
          )
        ],
      ),
    );
  }
}

class RatingProgressBar extends StatelessWidget {
  final double totalPercent;
  final String leadHeading;

  RatingProgressBar({required this.totalPercent, required this.leadHeading});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      width: MediaQuery.of(context).size.width * 0.45,
      lineHeight: 10.0,
      barRadius: Radius.circular(5),
      percent: totalPercent,
      leading: Text(leadHeading),
      progressColor: Colors.blue,
    );
  }
}