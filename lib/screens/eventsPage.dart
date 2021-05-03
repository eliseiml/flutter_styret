import 'package:flutter/material.dart';
import 'package:flutter_styret_app/domain/event.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:flutter_styret_app/utilites/textStyles.dart';

class EventsPage extends StatefulWidget {
  final Property property;

  EventsPage(this.property);

  @override
  EventsPageState createState() => EventsPageState(property);
}

class EventsPageState extends State<EventsPage> {
  Property property;

  EventsPageState(this.property);

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
                Text('Oppgaver', style: kPropertyTitleTextStyle),
                Spacer(),
                Text('Frist', style: kPropertyTitleTextStyle)
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: property.events.length,
                itemBuilder: (context, index) {
                  return eventTile(context, property.events[index], () {});
                }),
          )
        ],
      ),
    );
  }

  Widget eventTile(BuildContext contetxt, Event event, void onTap()) {
    String day = event.dateTime.day.toString();
    String month = event.dateTime.month.toString();
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
                child: Text(event.title,
                    maxLines: 3, style: kPropertyAddressTextStyle)),
            Container(
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: event.dateTime.isBefore(DateTime.now())
                    ? kAttentionColor
                    : kAttention2Color,
              ),
              child: Text('$day.$month.${event.dateTime.year}',
                  style: kNotificationTextStyle),
            )
          ],
        ),
      ),
    );
  }
}
