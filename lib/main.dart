import 'package:flutter/material.dart';
import 'package:flutter_styret_app/screens/loginPage.dart';

void main() {
  runApp(StyretApp());
}

class StyretApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Styret.com',
      home: LoginPage(),
    );
  }
}
