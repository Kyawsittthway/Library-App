import 'package:flutter/material.dart';

class CollectionPageEbookView extends StatelessWidget {

  final String imagePath;
  final String title;
  final String author;
  CollectionPageEbookView({
    required this.imagePath,
    required this.title,
    required this.author
});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 300,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    width: 200,
                    height: 300,
                    child: Image.network(
                        "$imagePath",
                        fit: BoxFit.cover),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(icon: Icon(Icons.more_horiz,color: Colors.white,),onPressed: (){},),
                )
              ],
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(
              "$title",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Container(
            width: 140,
            child: Text(
              "$author",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}
