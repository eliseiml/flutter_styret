import 'package:flutter/material.dart';
import 'package:flutter_styret_app/domain/user.dart';
import 'package:flutter_styret_app/generated/l10n.dart';
import 'package:flutter_styret_app/models/authModel.dart';
import 'package:flutter_styret_app/screens/propertiesPage.dart';
import 'package:flutter_styret_app/utilites/colors.dart';

import 'loginPage.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _checkLogedIn();
    super.initState();
  }

  Future<void> _checkLogedIn() async {
    await Future.delayed(Duration(seconds: 2));
    String token = await authModel.secureStorage.read(key: 'token');
    if (token != null) {
      String id = await authModel.secureStorage.read(key: 'id');
      String name = await authModel.secureStorage.read(key: 'name');
      String email = await authModel.secureStorage.read(key: 'email');
      authModel.email = email;
      authModel.password = await authModel.secureStorage.read(key: 'password');
      String phone = await authModel.secureStorage.read(key: 'phone');
      user = User(int.parse(id), name, email, phone, token);
      //load users localization if it was setted
      String localization =
          await authModel.secureStorage.read(key: 'localization');
      if (localization != null) {
        S.load(Locale(localization));
      }
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PropertiesPage();
      }));
    } else {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentColor,
      body: Center(
        child: Image.asset('assets/images/splashlogo.png',
            height: 185, width: 197),
      ),
    );
  }
}
