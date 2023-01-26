import 'package:flutter/material.dart';
import 'package:library_app/pages/search_page.dart';

import '../resource/dimen.dart';

class TopSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
        decoration: BoxDecoration(color: Colors.white70),
        child: Material(
          elevation: 10.0,
          shadowColor: Colors.grey,
          borderRadius: BorderRadius.circular(BORDER_RADIUS_SMALL),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Play Books",
                        enabled: false,
                      ),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(45),
                    child: Image.network(
                        "https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg")),
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
      },
    );
  }
}