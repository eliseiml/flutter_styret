import 'package:flutter/material.dart';

class AwesomeIcon extends StatelessWidget {
  final Color color;
  final int icon;
  final String fontFamily;

  AwesomeIcon({this.color, @required this.icon, this.fontFamily = 'fawesome'});

  @override
  Widget build(BuildContext context) {
    return Icon(
      new IconData(icon, fontFamily: fontFamily),
      color: color ?? Colors.black,
    );
  }
}

class AwesomeIcons {
  static const int folderIcon = 0xf07b;
  static const int arrowRightIcon = 0xf054;
  static const int arrowDownIcon = 0xf107;
  static const int alertTriangleIcon = 0xf071;
  static const int propertyIcon = 0xf594; //fa-solid
  static const int menuIcon = 0xf141;
  static const int calendarIcon = 0xf073; //fa-solid
  static const int dropDownIcon = 0xf0d7;
  static const int rotateIcon = 0xf0e2;
  static const int pictureIcon = 0xf030; //fa-solid
  static const int fileIcon = 0xf56c; //fa-solid
  static const int uploadIcon = 0xf093;
}
