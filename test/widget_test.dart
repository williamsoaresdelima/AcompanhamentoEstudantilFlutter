// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:acompanhamento_estudantil/AppGlobalKeys.dart';
import 'package:acompanhamento_estudantil/firebase_options.dart';
import 'package:acompanhamento_estudantil/models/School.dart';
import 'package:acompanhamento_estudantil/providers/school_provider.dart';
import 'package:acompanhamento_estudantil/routes/route.dart';
import 'package:acompanhamento_estudantil/screens/school_edit_screen.dart';
import 'package:acompanhamento_estudantil/screens/school_insert_screen.dart';
import 'package:acompanhamento_estudantil/screens/school_list_screen.dart';
import 'package:acompanhamento_estudantil/screens/school_show_screen.dart';
import 'package:acompanhamento_estudantil/screens/sign_in_screen.dart';
import 'package:acompanhamento_estudantil/screens/supplies_insert_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:acompanhamento_estudantil/main.dart';
import 'package:provider/provider.dart';

void main() {
  group('screens', () {
    testWidgets('test interface SignInScreen', (tester) async {
      const signInScreen = MaterialApp(
        home: SignInScreen(),
      );

      await tester.pumpWidget(signInScreen);

      expect(find.byKey(AppSignInKeys.inputEmailKey), findsOneWidget);
      expect(find.byKey(AppSignInKeys.inputPasswordKey), findsOneWidget);
      expect(find.byKey(AppSignInKeys.buttonKey), findsOneWidget);
      expect(find.byKey(AppSignInKeys.buttonCreateAccountKey), findsOneWidget);
    });

    testWidgets('test interface SchoolListScreen', (tester) async {
      var schoolListScreen = MaterialApp(
        home: SchoolListScreen(),
      );

      await tester.pumpWidget(schoolListScreen);

      expect(find.byKey(AppSchoolListKeys.schoolList), findsOneWidget);
      expect(find.byKey(AppSchoolListKeys.addButtonSchool), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('test interface SuppliesInsertScreen', (tester) async {
      var school = School('0', 'name', [], [], 'location');
      Widget child = SuppliesInsertScreen();
      final key = GlobalKey<NavigatorState>();

      var test = MaterialApp(
        navigatorKey: key,
        home: FloatingActionButton(
          onPressed: () => key.currentState?.push(
            MaterialPageRoute<void>(
              settings: RouteSettings(arguments: school),
              builder: (_) => child,
            ),
          ),
          child: const SizedBox(),
        ),
      );

      await tester.pumpWidget(test);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byKey(AppSuppliesInsertKeys.buttonAddImage), findsOneWidget);
      expect(
          find.byKey(AppSuppliesInsertKeys.inputDescription), findsOneWidget);
      expect(find.byKey(AppSuppliesInsertKeys.buttonCancel), findsOneWidget);
      expect(find.byKey(AppSuppliesInsertKeys.buttonUpdate), findsOneWidget);
      expect(find.byKey(AppSuppliesInsertKeys.inputName), findsOneWidget);
      expect(find.byKey(AppSuppliesInsertKeys.inputPrice), findsOneWidget);
      expect(find.byKey(AppSuppliesInsertKeys.inputQuant), findsOneWidget);
    });

    testWidgets('test interface SchoolShowScreen', (tester) async {
      var school = School('0', 'name', [], [], 'location');
      Widget child = SchoolShowScreen();
      final key = GlobalKey<NavigatorState>();

      var materialApp = MaterialApp(
        navigatorKey: key,
        home: FloatingActionButton(
          onPressed: () => key.currentState?.push(
            MaterialPageRoute<void>(
              settings: RouteSettings(arguments: school),
              builder: (_) => child,
            ),
          ),
          child: const SizedBox(),
        ),
      );

      var test = MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SchoolProvider()),
        ],
        child: materialApp,
      );

      await tester.pumpWidget(test);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byKey(AppSchoolShowKeys.buttonEditSchool), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.byKey(AppSchoolShowKeys.buttonAddSupplies), findsOneWidget);
      expect(find.byKey(AppSchoolShowKeys.carouselImage), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('test interface SchoolInsertScreen', (tester) async {
      var school = School('0', 'name', [], [], 'location');
      final key = GlobalKey<NavigatorState>();

      const schoolInsertScreen = MaterialApp(
        home: SchoolInsertScreen(),
      );

      var test = MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SchoolProvider()),
        ],
        child: schoolInsertScreen,
      );

      await tester.pumpWidget(test);

      expect(find.byKey(AppSchoolInsertKeys.buttonAddImage), findsOneWidget);
      expect(find.byKey(AppSchoolInsertKeys.buttonCancel), findsOneWidget);
      expect(find.byKey(AppSchoolInsertKeys.buttonSave), findsOneWidget);
      expect(find.byKey(AppSchoolInsertKeys.inputLocation), findsOneWidget);
      expect(find.byKey(AppSchoolInsertKeys.inputName), findsOneWidget);
      expect(find.byIcon(Icons.camera), findsOneWidget);
    });

    testWidgets('test interface SchoolEditScreen', (tester) async {
      var school = School('0', 'name', [], [], 'location');
      Widget child = const SchoolEditScreen();
      final key = GlobalKey<NavigatorState>();

      var materialApp = MaterialApp(
        navigatorKey: key,
        home: FloatingActionButton(
          onPressed: () => key.currentState?.push(
            MaterialPageRoute<void>(
              settings: RouteSettings(arguments: school),
              builder: (_) => child,
            ),
          ),
          child: const SizedBox(),
        ),
      );

      var test = MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SchoolProvider()),
        ],
        child: materialApp,
      );

      await tester.pumpWidget(test);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byKey(AppSchoolEditKeys.buttonGetLocation), findsOneWidget);
      expect(find.byKey(AppSchoolEditKeys.inputName), findsOneWidget);
      expect(find.byIcon(Icons.gps_fixed), findsOneWidget);
      expect(find.byKey(AppSchoolEditKeys.buttonAddImage), findsOneWidget);
      expect(find.byIcon(Icons.camera), findsOneWidget);
      expect(find.byKey(AppSchoolEditKeys.buttonCancel), findsOneWidget);
      expect(find.byKey(AppSchoolEditKeys.buttonSave), findsOneWidget);
    });
  });
}
