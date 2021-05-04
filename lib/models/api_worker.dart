import 'package:flutter_styret_app/domain/discrepancy.dart';
import 'package:flutter_styret_app/domain/event.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/domain/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIworker {
  String uri = 'secure.styret.com';

  Future<bool> getPropertyEvents(Property property) async {
    print('get property Events');
    List<Event> events = [];
    List<Discrepancy> discrepancies = [];
    final response = await http.get(
        Uri.https(
            uri, 'api/v2/users/${user.id}/properties/min2/${property.id}'),
        headers: {
          'token': '${user.token}',
          'X-Requested-With': 'XMLHttpRequest'
        });
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> resp = jsonDecode(response.body);
      if (resp['status_code'] == 2000) {
        //parse events
        List<dynamic> unsignedEvents = resp['data'][0]['unsigned_events'];
        unsignedEvents.forEach((element) {
          //Event event = Event.fromMap(element);
          events.add(Event.fromMap(element));
        });
        //parse dicrepancies
        List<dynamic> unfixedDiscrepancies =
            resp['data'][0]['unfixed_discrepancies'];
        unfixedDiscrepancies.forEach((element) {
          discrepancies.add(Discrepancy.fromMap(element['Discrepancy']));
        });
      }

      property.events = events;
      property.discrepancies = discrepancies;
      print('get property events end');
      return true;
    } else {
      print('get property events end');
      return false;
    }
  }

  Future<bool> getEvent(Event event) async {
    final response = await http.get(Uri.https(uri, 'api/v2/events/${event.id}'),
        headers: {
          'token': '${user.token}',
          'X-Requested-With': 'XMLHttpRequest'
        });
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> resp = jsonDecode(response.body)['event'];
      await event.fillAdditionalFromMap(resp);
      return true;
    }
    return false;
  }
}
