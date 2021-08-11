import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_styret_app/generated/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_styret_app/screens/loginPage.dart';
import 'package:flutter/material.dart';

Widget createLoginPage() => MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: LoginPage(),
      ),
    );

void main() {
  group("loginPage Widget test", () {
    testWidgets('Page should contain Container', (tester) async {
      await tester.pumpWidget(createLoginPage());
      expect(find.byType(Container), findsWidgets);
    });
  });
}
