import 'package:flutter/material.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/domain/user.dart';
import 'package:flutter_styret_app/models/authModel.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:flutter_styret_app/utilites/strings.dart';
import 'package:flutter_styret_app/utilites/textStyles.dart';

class PropertiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kAccentColor,
        title: Text(kListOfProperties, style: kAppBarTitleTextStyle),
        actions: [Icon(Icons.more_vert), Container(width: 15)],
      ),
      body: FutureBuilder(
        future: authModel.fetchProperties(),
        builder: (context, snapshot) {
          if (user.properties.length > 0) {
            return SizedBox(
              child: ListView.builder(
                  itemCount: user.properties.length,
                  itemBuilder: (context, index) {
                    if (user.properties.length == 0) {
                      return Text("No properties found...");
                    }
                    return propertyTile(context, user.properties[index]);
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kAccentColor),
              ),
            );
          }
        },
      ),
    );
  }

  Widget propertyTile(BuildContext context, Property property) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: kAccentColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //icon
          Image.asset('assets/icons/house.png', height: 18, width: 20),
          //Spacing
          Container(width: 15),
          //Title
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Text(property.name, style: kPropertyTitleTextStyle),
              //address
              Text(property.address, style: kPropertyAddressTextStyle)
            ],
          )),
          //arrow-right
          Icon(Icons.keyboard_arrow_right_outlined)
        ],
      ),
    );
  }
}
