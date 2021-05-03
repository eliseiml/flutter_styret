import 'package:flutter/material.dart';
import 'package:flutter_styret_app/domain/discrepancy.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:flutter_styret_app/utilites/textStyles.dart';

class DiscrepanciesPage extends StatefulWidget {
  final Property property;

  DiscrepanciesPage(this.property);

  @override
  DiscrepanciesPageState createState() => DiscrepanciesPageState(property);
}

class DiscrepanciesPageState extends State<DiscrepanciesPage> {
  Property property;
  String prevVendorName;

  DiscrepanciesPageState(this.property);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: kAccentColor,
        title: Text(property.name + " " + property.address,
            style: kAppBarTitleTextStyle),
      ),
      body: Column(
        children: [
          //titles
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              children: [
                Text('Avvik', style: kPropertyTitleTextStyle),
                Spacer(),
                Text('Registrert', style: kPropertyTitleTextStyle)
              ],
            ),
          ),
          getPageContent(context)
        ],
      ),
    );
  }

  List<Widget> content = [];
  Widget getPageContent(BuildContext context) {
    property.discrepancies.sort((a, b) => a.vendorName.compareTo(b.vendorName));
    property.discrepancies.forEach((discrepancy) {
      if (prevVendorName != discrepancy.vendorName) {
        prevVendorName = discrepancy.vendorName;
        content.add(sectionHeader(context, discrepancy.vendorName));
      }
      content.add(discrepancyTile(context, discrepancy, () {}));
    });
    return Expanded(
      child: ListView.builder(
          itemCount: content.length,
          itemBuilder: (context, index) {
            return content[index];
          }),
    );
  }

  Widget discrepancyTile(
      BuildContext contetxt, Discrepancy discrepancy, void onTap()) {
    String day = discrepancy.createdDateTime.day.toString();
    String month = discrepancy.createdDateTime.month.toString();
    if (day.length < 2) day = '0$day';
    if (month.length < 2) month = '0$month';

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
            //text
            Expanded(
                child: Text(discrepancy.title,
                    maxLines: 3, style: kPropertyAddressTextStyle)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: kAccentColor,
                  ),
                  child: Text('$day.$month.${discrepancy.createdDateTime.year}',
                      style: kNotificationTextStyle),
                ),
                Container(height: 5),
                Text(
                  discrepancy.improvementProgressStatus,
                  style: kInputTextStyle,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget sectionHeader(BuildContext context, String title) {
    return Container(
      color: kAccentColor,
      padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: kButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
