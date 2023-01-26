import 'package:flutter/material.dart';
import 'package:library_app/pages/home_page.dart';

import '../pages/library_page.dart';

class BottomNavigationBarWidget extends StatefulWidget {
   int currentPageIndex;
   Key key;
  BottomNavigationBarWidget(this.key,{
     required this.currentPageIndex
});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentPageIndex,
      onTap: (int index){
        if(index == widget.currentPageIndex){
          return;
        }else {
          switch (index) {
            case 0:
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => route is HomePage);
              break;
            case 1:
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LibraryPage("")),
                      (Route<dynamic> route) => route is LibraryPage);
              break;
          }
        }
        setState(() {
          widget.currentPageIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books_outlined),
          label: 'Library',
          backgroundColor: Colors.red,
        )
      ],
    );
  }
}
