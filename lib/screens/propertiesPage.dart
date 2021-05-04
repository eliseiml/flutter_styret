import 'package:flutter/material.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/domain/user.dart';
import 'package:flutter_styret_app/generated/l10n.dart';
import 'package:flutter_styret_app/models/authModel.dart';
import 'package:flutter_styret_app/screens/propertyCategoriesPage.dart';
import 'package:flutter_styret_app/utilites/awesomeIcons.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:flutter_styret_app/utilites/textStyles.dart';

import 'loginPage.dart';

class PropertiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kAccentColor,
        title:
            Text(S.of(context).kListOfProperties, style: kAppBarTitleTextStyle),
        actions: [
          IconButton(
              icon: Icon(Icons.logout)
              /*  AwesomeIcon(
                  icon: AwesomeIcons.menuIcon, color: kButtonTextColor) */
              ,
              onPressed: () async {
                await authModel.logout();
                while (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              }),
          Container(width: 5)
        ],
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
                      return Text(S.of(context).kNoPropertiesFound);
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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PropertyCategoriesPage(property);
        }));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3, color: kAccentColor)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //icon
            AwesomeIcon(
                icon: AwesomeIcons.propertyIcon,
                fontFamily: 'fa-solid',
                color: kAccentColor),
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
      ),
    );
  }
}
