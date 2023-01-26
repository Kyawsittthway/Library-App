import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:library_app/common_widgets/bottom_navigation_bar.dart';
import 'package:library_app/data.vo/book_vo.dart';
import 'package:library_app/data.vo/list_vo.dart';
import 'package:library_app/data.vo/shelf_vo.dart';
import 'package:library_app/main.dart';
import 'package:library_app/pages/add_to_shelves_page.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/pages/library_page.dart';
import 'package:library_app/persistence/hive_constants.dart';
import 'package:library_app/viewitems/shelf_collection_view_item.dart';

import 'test_data/keys.dart';
import 'test_data/test_data.dart';

void main() async {
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


    // ///Go to first book detail
    // await tester.tap(find.text(TEST_BOOK_NAME_2));
    // await tester.pumpAndSettle(Duration(seconds: 5));
    //
    // ///Check Data in Book Detail Page
    // expect(find.text(TEST_BOOK_NAME_2), findsOneWidget);
    // expect(find.text(TEST_BOOK_AUTHOR_2), findsOneWidget);
    // expect(find.text(TEST_BOOK_DESCRIPTION_2), findsOneWidget);

    ///back to homepage
    // await tester.tap(find.byKey(bookDetailBackButtonKey));
    // await tester.pumpAndSettle(Duration(seconds: 5));

    /// Scroll to second books and Check Data
    await tester.drag(find.byType(HomePage), Offset(0, -1100));
    expect(find.text(TEST_BOOK_NAME_1), findsOneWidget);
    expect(find.text(TEST_BOOK_AUTHOR_1), findsOneWidget);

    await tester.tap(find.text(TEST_BOOK_NAME_1));
    await tester.pumpAndSettle(Duration(seconds: 5));

    ///Check Data in Book Detail Page for book 2
    expect(find.text(TEST_BOOK_NAME_1), findsOneWidget);
    expect(find.text(TEST_BOOK_AUTHOR_1), findsOneWidget);
    expect(find.text(TEST_BOOK_DESCRIPTION_1), findsOneWidget);

    ///back to homepage from book 2
    await tester.tap(find.byKey(bookDetailBackButtonKey));
    await tester.pumpAndSettle(Duration(seconds: 5));


    await tester.tap(find.byKey(bottomNavigationBarKey));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(shelfOrBookTabKey));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.text(CREATE_NEW_BUTTON_TEXT));
    await tester.pumpAndSettle(Duration(seconds: 7));

    expect(find.text(CREATE_SHELF_TEXT), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);

    ///Entering the shelf name
    await tester.enterText(find.byType((TextFormField)), SHELF_NAME);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(shelfOrBookTabKey));
    await tester.pumpAndSettle(Duration(seconds: 5));
    expect(find.text(SHELF_NAME), findsOneWidget);


    await tester.tap(find.byKey(shelfOrBookTabKey));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.text(TEST_BOOK_NAME_1));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.text(ADD_TO_SHELF_TEXT));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text(SHELF_NAME), findsOneWidget);
    await tester.pumpAndSettle(Duration(seconds: 8));
    // await tester.tap(find.byType(ShelfCollectionItemGestureDector),warnIfMissed: false);
    // await tester.tap(find.byKey(shelfCollectionItemKey),warnIfMissed: false);
    await tester.tap(find.text(SHELF_NAME),warnIfMissed: false);
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(LibraryPage),findsOneWidget);


    await tester.tap(find.byKey(shelfOrBookTabKey,skipOffstage: false));
    await tester.pumpAndSettle(Duration(seconds: 5));


    ///Go to shelf detail
    await tester.ensureVisible(find.byType(ShelfCollectionViewItem));
    await tester.pumpAndSettle(Duration(seconds: 3));
    await tester.tap(find.text(SHELF_NAME),warnIfMissed: false);
    await tester.pumpAndSettle(Duration(seconds: 5));
    expect(find.text(SHELF_NAME), findsOneWidget);
    expect(find.text(ADD_BOOK_COUNT_TEXT), findsOneWidget);

    // /// Check Sorting in Library
    // await tester.tap(find.byKey(sortingOptionsButtonViewKey));
    // await tester.pumpAndSettle(Duration(seconds: 3));
    // await tester.pump(const Duration(milliseconds: 100));
    // await tester.tap(find.byKey(sortByTitleKey));
    //
    //
    // await tester.pumpAndSettle(Duration(seconds: 3));
    //
    //
    // await tester.tap(find.byKey(sortingOptionsButtonViewKey));
    // await tester.pumpAndSettle(Duration(seconds: 3));
    //
    // await tester.tap(find.byKey(sortByAuthorKey));
    // await tester.pumpAndSettle(Duration(seconds: 5));
    //
    //
    // /// Check View As in Library
    // await tester.tap(find.byKey(viewAsOptionKey));
    // await tester.pumpAndSettle(Duration(seconds: 3));
    //
    //
    // await tester.tap(find.byKey(viewAsLargeGridKey));
    // await tester.pumpAndSettle(Duration(seconds: 5));
    //
    // await tester.tap(find.byKey(viewAsOptionKey));
    // await tester.pumpAndSettle(Duration(seconds: 3));
    // await tester.tap(find.byKey(viewAsSmallGridKey));
    // await tester.pumpAndSettle(Duration(seconds: 5));
    //
    // await tester.tap(find.byKey(viewAsOptionKey));
    // await tester.pumpAndSettle(Duration(seconds: 3));
    // await tester.tap(find.byKey(viewAsListKey));
    // await tester.pumpAndSettle(Duration(seconds: 5));

    ///Check rename
    await tester.tap(find.byKey(shelfDetailOptionKey));
    await tester.pumpAndSettle(Duration(seconds: 5));
    // expect(find.text(SHELF_NAME), findsOneWidget);

    await tester.tap(find.text(RENAME_SHELF_TEXT));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.enterText(find.byType((TextFormField)), NEW_SHELF_NAME);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(shelfOrBookTabKey));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.text(NEW_SHELF_NAME),warnIfMissed: false);
    await tester.pumpAndSettle(Duration(seconds: 5));
    expect(find.text(NEW_SHELF_NAME), findsOneWidget);
    expect(find.text(ADD_BOOK_COUNT_TEXT), findsOneWidget);

    ///Delete Shelf
    await tester.tap(find.byKey(shelfDetailOptionKey));
    await tester.pumpAndSettle(Duration(seconds: 5));


    await tester.tap(find.text(DELETE_SHELF_TEXT));
    await tester.pumpAndSettle(Duration(seconds: 5));

    await tester.tap(find.byKey(shelfOrBookTabKey));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byType(EmptyShelfView), findsOneWidget);
  });
}