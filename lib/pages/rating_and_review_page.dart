import 'package:flutter/material.dart';
import 'package:library_app/resource/dimen.dart';
import 'package:library_app/viewitems/custom_chip_view.dart';
import 'package:library_app/viewitems/rating_stars_and_bars_view.dart';
import 'package:library_app/viewitems/review_comment_section_view.dart';

class RatingAndReviewPage extends StatelessWidget {
  const RatingAndReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Ratings and reviews",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top:MARGIN_MEDIUM_2,left: 5.0,right:5.0),
          child: Column(
            children: [
              RatingStarAndBarView(),
              SizedBox(height: MARGIN_MEDIUM,),
              Wrap(
                direction: Axis.horizontal,
                spacing: MARGIN_MEDIUM,
                runSpacing: MARGIN_MEDIUM,
                children: [
                  GestureDetector(child: FilterChipView(genre: "1", width: 55, height: 45, isCenter: true),onTap: (){},),
                  GestureDetector(child: FilterChipView(genre: "2", width: 55, height: 45, isCenter: true),onTap: (){},),
                  GestureDetector(child: FilterChipView(genre: "3", width: 55, height: 45, isCenter: true),onTap: (){},),
                  GestureDetector(child: FilterChipView(genre: "4", width: 55, height: 45, isCenter: true),onTap: (){},),
                  GestureDetector(child: FilterChipView(genre: "5", width: 55, height: 45, isCenter: true),onTap: (){},)
                ],
              ),
              ReviewCommentsSectionView()
            ],
          ),
        ),
      ),
    );
  }
}

// class ReviewFilterButton extends StatelessWidget {
//   final String buttonLabel;
//   Function onTapAction;
//
//   ReviewFilterButton({required this.buttonLabel, required this.onTapAction});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(69)
//       ),
//       child: ElevatedButton.icon(
//
//         onPressed: () {
//           onTapAction();
//         },
//         icon: Icon(icons.star, color: Colors.grey),
//         label: Text(
//           buttonLabel,
//           style: TextStyle(color: Colors.grey),
//         ),
//         style: ElevatedButton.styleFrom(primary: Colors.white,side: BorderSide(color: Colors.grey.shade50,),),
//       ),
//     );
//   }
// }
