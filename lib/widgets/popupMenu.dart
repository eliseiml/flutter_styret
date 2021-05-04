import 'package:flutter/material.dart';
import 'package:flutter_styret_app/generated/l10n.dart';
import 'package:flutter_styret_app/models/authModel.dart';
import 'package:flutter_styret_app/screens/loginPage.dart';
import 'package:flutter_styret_app/utilites/awesomeIcons.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:flutter_styret_app/utilites/textStyles.dart';

enum Languages { English, Norwegian, Russian }
String langValue = '';

Widget popUpMenu(BuildContext context, void onLangChanged()) {
  return PopupMenuButton(
    color: kMenuBackgroundColor,
    child: AwesomeIcon(icon: AwesomeIcons.menuIcon, color: kButtonTextColor),
    onSelected: (val) {
      switch (val) {
        case 0:
          {
            S.load(Locale('en'));
            authModel.secureStorage.write(key: 'localization', value: 'en');
            onLangChanged();
          }
          break;
        case 1:
          {
            S.load(Locale('nb'));
            authModel.secureStorage.write(key: 'localization', value: 'nb');
            onLangChanged();
          }
          break;
        case 2:
          {
            S.load(Locale('ru'));
            authModel.secureStorage.write(key: 'localization', value: 'ru');
            onLangChanged();
          }
          break;
        case 3:
          {
            authModel.logout();
            while (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginPage();
            }));
          }
          break;
      }
    },
    itemBuilder: (context) {
      return [
        //Language English
        PopupMenuItem(
          value: 0,
          child: Text(
              S.of(context).kLanguage + ": " + S.of(context).kLangEnglish,
              style: kMenuTextStyle),
        ),
        //Norwegian
        PopupMenuItem(
          value: 1,
          child: Text(
              S.of(context).kLanguage + ": " + S.of(context).kLangNorwegian,
              style: kMenuTextStyle),
        ),
        //Russian
        PopupMenuItem(
          value: 2,
          child: Text(
              S.of(context).kLanguage + ": " + S.of(context).kLangRussian,
              style: kMenuTextStyle),
        ),
        //Log out
        PopupMenuItem(
          value: 3,
          child: Text(S.of(context).kLogout, style: kMenuTextStyle),
        )
      ];
    },
  );
}
