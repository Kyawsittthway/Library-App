import 'package:flutter/material.dart';

import '../common_widgets/review_comment_widget.dart';
import '../resource/dimen.dart';

class ReviewCommentsSectionView extends StatelessWidget {
  const ReviewCommentsSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      height: MediaQuery.of(context).size.height * 0.65,
      child: ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return ReviewCommentWidget(
              reviewerRating: 3.0,
              date: '5/21/14',
              reviewerImagePath:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Aaron_Paul_by_Gage_Skidmore_3.jpg/440px-Aaron_Paul_by_Gage_Skidmore_3.jpg",
              reviewContent:
              "F CATS DISAPPEARED FROM THE WORLD is a beautiful, comforting story despite the grisly premise. It's about a young man's journey towards accepting the end and making peace with it. And it's about cats. I'd recommend if you love cats, Japanese fiction or speculative writings about life and death",
              reviewerName: 'Jessie PinkMan',
            );
          }),
    );
  }
}