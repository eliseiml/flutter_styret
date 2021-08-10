import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_styret_app/screens/splashScreen.dart';
import 'generated/l10n.dart';
import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppCenter.startAsync(
    appSecretAndroid: 'bfe51389-c352-41a5-8428-a6470deaa024',
    appSecretIOS: 'c9d7ae70-ef06-4471-a1b2-bc336559c308',
    enableDistribute: false,
  );
  runApp(StyretApp());
}

class StyretApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Styret.com',
      home: SplashPage(),
    );
  }
}
