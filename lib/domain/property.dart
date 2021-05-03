import 'package:flutter_styret_app/domain/discrepancy.dart';

import 'event.dart';

class Property {
  int id;
  String name;
  String address;
  int countEvents;
  List<Event> events = [];
  List<Discrepancy> discrepancies = [];

  Property(this.id, this.name, this.address, this.countEvents);

  factory Property.fromMap(Map<String, dynamic> data) {
    return Property(
        data['id'], data['name'], data['address'], data['count_events']);
  }

  void printInfo() {
    print('id: $id');
    print('name: $name');
    print('address: $address');
    print('count_events: $countEvents');
  }
}
