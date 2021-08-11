import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styret_app/screens/splashScreen.dart';

Widget createLoginPage() => MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: SplashPage(),
      ),
    );

void main() {
  group("splashPage Widget test", () {
    testWidgets('Page should contain Scaffold', (tester) async {
      await tester.pumpWidget(createLoginPage());
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('Page should contain Center', (tester) async {
      await tester.pumpWidget(createLoginPage());
      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('Page should contain Image', (tester) async {
      await tester.pumpWidget(createLoginPage());
      expect(find.byType(Image), findsWidgets);
    });
  });
}
