import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

Widget tilesGridView(
    {@required BuildContext context, @required List<Widget> items}) {
  //Calculte columns
  int columns = items.length > 2 ? 3 : items.length;
  //List of columns
  List<Widget> columnsList = [];
  //Distibute tiles to columns
  for (int i = 0; i < columns; i++) {
    List<Widget> tiles = [];
    for (int c = i; c < items.length; c += columns) {
      tiles.add(items[c]);
      //Vertival spacing
      if (c < items.length - columns) {
        tiles.add(SizedBox(height: 5));
      }
    }
    columnsList.add(Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: tiles,
      ),
    ));
    //Horizontal spacing
    if (i != columns - 1) {
      columnsList.add(SizedBox(width: 5));
    }
  }
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnsList,
    ),
  );
}
