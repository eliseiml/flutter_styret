import 'package:flutter/material.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/domain/user.dart';
import 'package:flutter_styret_app/generated/l10n.dart';
import 'package:flutter_styret_app/models/authModel.dart';
import 'package:flutter_styret_app/screens/propertyCategoriesPage.dart';
import 'package:flutter_styret_app/utilites/awesomeIcons.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:flutter_styret_app/utilites/textStyles.dart';
import 'package:flutter_styret_app/widgets/popupMenu.dart';

class PropertiesPage extends StatefulWidget {
  @override
  PropertiesPageState createState() => PropertiesPageState();
}

class PropertiesPageState extends State<PropertiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: kAccentColor,
        title:
            Text(S.of(context).kListOfProperties, style: kAppBarTitleTextStyle),
        actions: [
          popUpMenu(context, () {
            setState(() {});
          }),
          Container(width: 20)
        ],
      ),
      body: FutureBuilder(
        future: authModel.fetchProperties(),
        builder: (context, snapshot) {
          Widget content;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              content = SizedBox(
                child: ListView.builder(
                    itemCount: user.properties.length,
                    itemBuilder: (context, index) {
                      return propertyTile(context, user.properties[index]);
                    }),
              );
            } else {
              content = Center(
                child: Text(S.of(context).kLoadingError,
                    style: kPropertyTitleTextStyle),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            content = Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kAccentColor),
              ),
            );
          }
          return content;
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
