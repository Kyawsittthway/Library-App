import 'package:flutter/material.dart';

import '../resource/dimen.dart';

class TappableHeaderWidget extends StatelessWidget {
  TappableHeaderWidget({
    required this.title,
    required this.isAudio,
    required this.onTapAction
  });

  final String title;
  final bool isAudio;
  Function onTapAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      child: GestureDetector(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: FONT_REGULAR_2X,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 23),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue,
                    size: 20,
                  )),
            )
          ],
        ),
        onTap: () {
          onTapAction();
        },
      ),
    );
  }
}
