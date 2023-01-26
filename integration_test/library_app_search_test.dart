import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:integration_test/integration_test.dart';
import 'package:library_app/common_widgets/top_search_bar.dart';
import 'package:library_app/data.vo/book_vo.dart';
import 'package:library_app/data.vo/list_vo.dart';
import 'package:library_app/data.vo/shelf_vo.dart';
import 'package:library_app/main.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/persistence/hive_constants.dart';

import 'test_data/test_data.dart';


/// Test all results from query
void main()async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();


  await Hive.initFlutter();

  Hive.registerAdapter(ShelfVOAdapter());
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(ListVOAdapter());

  await Hive.openBox<ShelfVO>(BOX_NAME_SHELF_VO);
  await Hive.openBox<BookVO>(BOX_NAME_BOOK_VO);
  await Hive.openBox<BookVO>(BOX_NAME_CURRENT_BOOKS);
  await Hive.openBox<ListVO>(BOX_NAME_LIST_VO);

  testWidgets("Shelf Testing", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await Future.delayed(Duration(seconds: 2));

    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(HomePage),findsOneWidget);

    await tester.tap(find.byType(TopSearchBar));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.enterText(find.byType((TextFormField)), SEARCH_QUERY);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(Duration(seconds: 10));

    expect(find.text(QUERY_BOOK_NAME),findsOneWidget);
    expect(find.text(QUERY_BOOK_AUTHOR),findsOneWidget);

  });

}