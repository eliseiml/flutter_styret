import 'package:flutter/material.dart';
import 'package:flutter_styret_app/utilites/awesomeIcons.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:meta/meta.dart';

Widget dropdownPicker({
  @required BuildContext context,
  @required List<dynamic> items,
  @required dynamic value,
  @required Function(dynamic selected) onChanged,
}) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    constraints: BoxConstraints(maxHeight: 40),
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
        border: Border.all(color: kInactiveTextColor, width: 2),
        borderRadius: BorderRadius.circular(10)),
    child: DropdownButton(
      value: value,
      items: items.map<DropdownMenuItem<dynamic>>((val) {
        return DropdownMenuItem<dynamic>(
          value: val,
          child: Text(val.title),
        );
      }).toList(),
      icon: AwesomeIcon(icon: AwesomeIcons.dropDownIcon, color: kAccentColor),
      underline: Container(),
      onChanged: (val) {
        onChanged(val);
      },
    ),
  );
}

/*     
  
  DropdownButton<String>(
    value: dropdownValue,
    icon: const Icon(Icons.arrow_downward),
    iconSize: 24,
    elevation: 16,
    style: const TextStyle(color: Colors.deepPurple),
    underline: Container(
      height: 2,
      color: Colors.deepPurpleAccent,
    ),
    onChanged: (String newValue) {},
    items: <String>['One', 'Two', 'Free', 'Four']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  )*/
