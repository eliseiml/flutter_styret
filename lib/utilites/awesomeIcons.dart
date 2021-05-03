import 'package:flutter/material.dart';

class AwesomeIcon extends StatelessWidget {
  final Color color;
  final int icon;

  AwesomeIcon({this.color, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Icon(
      IconData(icon, fontFamily: 'fawesome'),
      color: color ?? Colors.black,
    );
  }
}

class AwesomeIcons {
  static const int folderIcon = 0xf07b;
  static const int arrowRightIcon = 0xf054;
  static const int alertTriangleIcon = 0xf071;
}
