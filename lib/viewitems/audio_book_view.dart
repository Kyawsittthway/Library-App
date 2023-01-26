import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../resource/dimen.dart';

class AudioBookView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(BORDER_RADIUS_SMALL),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(BORDER_RADIUS_SMALL),
                  child: Image.network(
                    "https://jamesclear.com/wp-content/uploads/2016/06/sapiens-by-yuval-noah-harari.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: IconButton(
                    icon:Icon(Icons.more_horiz),
                    onPressed: (){},
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
                  child: IconButton(
                    icon:Icon(Icons.headset),
                    onPressed: (){},
                  ),
                ),
              ),


            ],
          ),
        ),
        Container(
          width: 140,
          child: Text(
            "The mind of leader",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Container(
          width: 140,
          child: Text(
            "Kevin Anderson",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        )
      ],
    );
  }
}
