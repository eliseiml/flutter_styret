import 'package:flutter/material.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:meta/meta.dart';

Widget gridTile({
  @required BuildContext context,
  @required String text,
  bool state = false,
  Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.translucent,
    child: Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(maxHeight: 30),
      decoration: BoxDecoration(
          color: state ? kAccentColor : kBackgroundColor,
          border: Border.all(color: kInactiveTextColor, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        text,
        style: TextStyle(color: state ? kButtonTextColor : Colors.black),
      ),
    ),
  );
}
