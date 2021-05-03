import 'package:flutter/material.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/models/api_worker.dart';
import 'package:flutter_styret_app/screens/eventsPage.dart';
import 'package:flutter_styret_app/utilites/awesomeIcons.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:flutter_styret_app/utilites/textStyles.dart';

import 'discrepanciesPage.dart';

class PropertyCategoriesPage extends StatefulWidget {
  final Property property;

  PropertyCategoriesPage(this.property);

  @override
  PropertyCategoriesPageState createState() =>
      PropertyCategoriesPageState(property);
}

class PropertyCategoriesPageState extends State<PropertyCategoriesPage> {
  final Property property;
  final APIworker api = new APIworker();

  PropertyCategoriesPageState(this.property);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: kAccentColor,
        title: Text(property.name + " " + property.address,
            style: kAppBarTitleTextStyle),
      ),
      body: FutureBuilder(
        future: api.getPropertyEvents(property),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                categoryTile(context, 'Oppgaver', () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EventsPage(property);
                  }));
                }, AwesomeIcons.folderIcon, property.events.length),
                categoryTile(context, 'Avvik', () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DiscrepanciesPage(property);
                  }));
                }, AwesomeIcons.alertTriangleIcon,
                    property.discrepancies.length)
              ],
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

  Widget categoryTile(BuildContext context, String title, void onTap(),
      int icon, int quantity) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
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
            AwesomeIcon(icon: icon, color: kAccentColor),
            //Spacing
            Container(width: 15),
            //Title
            Expanded(child: Text(title, style: kPropertyTitleTextStyle)),
            //Quantity
            Text('$quantity', style: kPropertyAddressTextStyle)
          ],
        ),
      ),
    );
  }
}
