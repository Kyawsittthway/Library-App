import 'package:flutter/material.dart';
import 'package:library_app/blocs/shelf_detail_page_bloc.dart';
import 'package:library_app/pages/library_page.dart';
import 'package:library_app/resource/dimen.dart';
import 'package:provider/provider.dart';

class CreateNewShelfPage extends StatefulWidget {


  final bool isCreateNewShelf;
  String? oldName;


  CreateNewShelfPage(this.oldName,{required this.isCreateNewShelf});

  @override
  State<CreateNewShelfPage> createState() => _CreateNewShelfPageState();
}

class _CreateNewShelfPageState extends State<CreateNewShelfPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ShelfDetailPageBloc(widget.oldName ?? ""),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Create Shelf",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            )),
        body: SingleChildScrollView(
          child: Center(
            child: Consumer<ShelfDetailPageBloc>(
              builder: (context,bloc,child)=> Container(
                height: 300.0,
                padding: EdgeInsets.all(MARGIN_MEDIUM_3),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  onFieldSubmitted: (String input){
                    if(widget.isCreateNewShelf == true){
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LibraryPage(input)),
                              (Route<dynamic> route) => route is LibraryPage);
                    }else{
                      bloc.updateName(input);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LibraryPage("")),
                              (Route<dynamic> route) => route is LibraryPage);
                    }

                  },
                  style: TextStyle(fontSize: LARGE_FONT_SIZE),
                  maxLength: 50,
                  decoration: InputDecoration(hintText: "Shelf name"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
