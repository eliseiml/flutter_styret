import 'package:flutter/material.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:flutter_styret_app/utilites/textStyles.dart';

Widget button({BuildContext context, String title, void onTap()}) {
  return GestureDetector(
    child: Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 80),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: kAccentColor, boxShadow: [
        BoxShadow(
            color: kInactiveColor,
            blurRadius: 6,
            offset: Offset(0, 5),
            spreadRadius: 4)
      ]),
      child: Text(title, style: kButtonTextStyle),
    ),
  );
}
