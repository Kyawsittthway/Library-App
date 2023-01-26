import 'package:flutter/material.dart';
import 'package:library_app/blocs/add_to_shelves_page_bloc.dart';
import 'package:library_app/network/api_constants.dart';
import 'package:library_app/resource/dimen.dart';
import 'package:library_app/viewitems/shelf_collection_view_item.dart';
import 'package:provider/provider.dart';

import '../data.vo/book_vo.dart';
import '../data.vo/shelf_vo.dart';
import 'library_page.dart';

class AddToShelvesPage extends StatelessWidget {
  final BookVO book;

  AddToShelvesPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value:AddToShelvesPageBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Add to shelves",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.black87,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Selector<AddToShelvesPageBloc, List<ShelfVO>>(
            selector: (context, bloc) => bloc.shelfList,
            builder: (context, shelfList, child) => Container(
              padding: EdgeInsets.all(MARGIN_MEDIUM_2),
              child: ListView.builder(
                  itemCount: shelfList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ShelfCollectionItemGestureDector(book: book,shelfList:shelfList ,index: index,);
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

class ShelfCollectionItemGestureDector extends StatelessWidget {
  const ShelfCollectionItemGestureDector({
    Key? key,
    required this.book,
    required this.shelfList,
    required this.index
  }) : super(key: key);

  final BookVO book;
  final List<ShelfVO> shelfList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key:Key("shelfCollectionViewItemKey"),
      child: ShelfCollectionViewItem(
        isAddToShelvesPage: true,
        bookCount: shelfList[index].bookList.length,
        shelfName: '${shelfList[index].shelfName}',
        stackBookCoverPath: shelfList[index].bookList.isEmpty? PLACEHOLDER_IMAGE_PATH:"${shelfList[index].bookList.last.bookImage}",
        stackBookCoverPath2: shelfList[index].bookList.isEmpty? PLACEHOLDER_IMAGE_PATH:"${shelfList[index].bookList.first.bookImage}", onTapAction: (){
        var bloc = Provider.of<AddToShelvesPageBloc>(context,
            listen: false);
        bloc.addBookToShelf(
            book, shelfList[index].shelfName ?? "");
        // Navigator.pop(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LibraryPage()),
                (Route<dynamic> route) => route is LibraryPage);
      },
      ),
      onTap: () {
        var bloc = Provider.of<AddToShelvesPageBloc>(context,
            listen: false);
        bloc.addBookToShelf(
            book, shelfList[index].shelfName ?? "");
        // Navigator.pop(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LibraryPage()),
                (Route<dynamic> route) => route is LibraryPage);

      },
    );
  }
}
