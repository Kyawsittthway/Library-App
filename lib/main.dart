import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:library_app/data.vo/book_vo.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/persistence/hive_constants.dart';

import 'data.vo/list_vo.dart';
import 'data.vo/shelf_vo.dart';


void main() async{
  await Hive.initFlutter();

  Hive.registerAdapter(ShelfVOAdapter());
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(ListVOAdapter());

  await Hive.openBox<ShelfVO>(BOX_NAME_SHELF_VO);
  await Hive.openBox<BookVO>(BOX_NAME_BOOK_VO);
  await Hive.openBox<BookVO>(BOX_NAME_CURRENT_BOOKS);
  await Hive.openBox<ListVO>(BOX_NAME_LIST_VO);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomePage()
    );
  }
}


