import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:library_app/common_widgets/bottom_navigation_bar.dart';
import 'package:library_app/data.vo/book_vo.dart';
import 'package:library_app/data.vo/list_vo.dart';
import 'package:library_app/data.vo/shelf_vo.dart';
import 'package:library_app/main.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/persistence/hive_constants.dart';

import 'test_data/keys.dart';
import 'test_data/test_data.dart';

void main()async{
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ShelfVOAdapter());
  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(ListVOAdapter());

  await Hive.openBox<ShelfVO>(BOX_NAME_SHELF_VO);
  await Hive.openBox<BookVO>(BOX_NAME_BOOK_VO);
  await Hive.openBox<BookVO>(BOX_NAME_CURRENT_BOOKS);
  await Hive.openBox<ListVO>(BOX_NAME_LIST_VO);

  testWidgets("HomePage and Current Book Testing", (WidgetTester tester) async{


      await tester.pumpWidget(MyApp());
      await Future.delayed(Duration(seconds: 2));

      await tester.pumpAndSettle(Duration(seconds:5));

      expect(find.byType(HomePage),findsOneWidget);

      // ///Check Data in HomePage
      // expect(find.text(TEST_BOOK_NAME_2,skipOffstage: false),findsOneWidget);
      // expect(find.text(TEST_BOOK_AUTHOR_2,skipOffstage: false),findsOneWidget);
      //
      // ///Go to first book detail
      // await tester.tap(find.text(TEST_BOOK_NAME_2));
      // await tester.pumpAndSettle(Duration(seconds: 5));
      //
      // ///Check Data in Book Detail Page
      // expect(find.text(TEST_BOOK_NAME_2),findsOneWidget);
      // expect(find.text(TEST_BOOK_AUTHOR_2),findsOneWidget);
      // expect(find.text(TEST_BOOK_DESCRIPTION_2),findsOneWidget);
      //
      // ///back to homepage
      // await tester.tap(find.byKey(bookDetailBackButtonKey));
      // await tester.pumpAndSettle(Duration(seconds:5));

      /// Scroll to second books and Check Data
      await tester.drag(find.byType(HomePage),Offset(0,-1100));
      expect(find.text(TEST_BOOK_NAME_1),findsOneWidget);
      expect(find.text(TEST_BOOK_AUTHOR_1),findsOneWidget);

      await tester.tap(find.text(TEST_BOOK_NAME_1));
      await tester.pumpAndSettle(Duration(seconds:5));

      ///Check Data in Book Detail Page for book 2
      expect(find.text(TEST_BOOK_NAME_1),findsOneWidget);
      expect(find.text(TEST_BOOK_AUTHOR_1),findsOneWidget);
      expect(find.text(TEST_BOOK_DESCRIPTION_1),findsOneWidget);

      ///back to homepage from book 2
      await tester.tap(find.byKey(bookDetailBackButtonKey));
      await tester.pumpAndSettle(Duration(seconds:5));

      /// Scroll to third books and Check Data
      await tester.drag(find.byType(HomePage), Offset(0, -1700)); /// -1100 : how to catch an elf , -2800: GO-TO Dinner
      expect(find.text(TEST_BOOK_NAME_3),findsOneWidget);
      expect(find.text(TEST_BOOK_AUTHOR_3),findsOneWidget);

      await tester.tap(find.text(TEST_BOOK_NAME_3));
      await tester.pumpAndSettle(Duration(seconds:5));

      ///Check Data in Book Detail Page for book 3
      expect(find.text(TEST_BOOK_NAME_3),findsOneWidget);
      expect(find.text(TEST_BOOK_AUTHOR_3),findsOneWidget);
      expect(find.text(TEST_BOOK_DESCRIPTION_3),findsOneWidget);

      ///back to homepage from book 3
      await tester.tap(find.byKey(bookDetailBackButtonKey));

      await tester.pumpAndSettle(Duration(seconds: 5));

      await tester.tap(find.byKey(bottomNavigationBarKey));
      await tester.pumpAndSettle(Duration(seconds:5));

      ///Check Data in Library Page
      expect(find.text(TEST_BOOK_NAME_1),findsOneWidget);
      expect(find.text(TEST_BOOK_AUTHOR_1),findsOneWidget);

      // expect(find.text(TEST_BOOK_NAME_2),findsOneWidget);
      // expect(find.text(TEST_BOOK_AUTHOR_2),findsOneWidget);

      expect(find.text(TEST_BOOK_NAME_3),findsOneWidget);
      expect(find.text(TEST_BOOK_AUTHOR_3),findsOneWidget);

      /// Check Sorting in Library
      await tester.tap(find.byKey(sortingOptionsButtonViewKey));
      await tester.pumpAndSettle(Duration(seconds: 3));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(find.byKey(sortByTitleKey));


      await tester.pumpAndSettle(Duration(seconds: 3));


      await tester.tap(find.byKey(sortingOptionsButtonViewKey));
      await tester.pumpAndSettle(Duration(seconds: 3));

      await tester.tap(find.byKey(sortByAuthorKey));
      await tester.pumpAndSettle(Duration(seconds: 5));

      /// Check View As in Library
      await tester.tap(find.byKey(viewAsOptionKey));
      await tester.pumpAndSettle(Duration(seconds: 3));


      await tester.tap(find.byKey(viewAsLargeGridKey));
      await tester.pumpAndSettle(Duration(seconds: 5));

      await tester.tap(find.byKey(viewAsOptionKey));
      await tester.pumpAndSettle(Duration(seconds: 3));
      await tester.tap(find.byKey(viewAsSmallGridKey));
      await tester.pumpAndSettle(Duration(seconds: 5));

      await tester.tap(find.byKey(viewAsOptionKey));
      await tester.pumpAndSettle(Duration(seconds: 3));
      await tester.tap(find.byKey(viewAsListKey));
      await tester.pumpAndSettle(Duration(seconds: 5));

      ///Testing Filter
      await tester.tap(find.text(TEST_BOOK_LIST_NAME_1));
      await tester.pumpAndSettle(Duration(seconds: 5));
      expect(find.text(TEST_BOOK_NAME_1), findsOneWidget);

      // await tester.tap(find.text(TEST_BOOK_LIST_NAME_2));
      // await tester.pumpAndSettle(Duration(seconds: 5));
      // expect(find.text(TEST_BOOK_NAME_2), findsOneWidget);

      await tester.tap(find.byKey(clearFilterKey));
      await tester.pumpAndSettle(Duration(seconds: 5));

      await tester.dragUntilVisible(find.text(TEST_BOOK_NAME_3), find.byKey(filterSectionKey), Offset(0, 200));
      await tester.pumpAndSettle(Duration(seconds: 5));
      await tester.tap(find.text(TEST_BOOK_LIST_NAME_3),warnIfMissed: false);
      await tester.pumpAndSettle(Duration(seconds: 5));
      expect(find.text(TEST_BOOK_NAME_3), findsOneWidget);











  });
}