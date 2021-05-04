import 'package:flutter_styret_app/domain/subTask.dart';

class Event {
  String id;
  String title;
  String cooperativeID;
  String eventDate;
  DateTime dateTime;
  //Additional
  int propertyId;
  String description;
  bool requireSigning;
  bool signed;
  String signedDate;
  String signedBy;
  List<SubTask> subTasks = [];

  Event(this.id, this.title, this.cooperativeID, this.eventDate) {
    dateTime = DateTime.parse(eventDate);
  }

  factory Event.fromMap(Map<String, dynamic> json) {
    return Event(
        json['id'], json['title'], json['borettslag_id'], json['event_date']);
  }

  Future<void> fillAdditionalFromMap(Map<String, dynamic> map) async {
    propertyId = map['property_id'];
    description = map['description'];
    requireSigning = map['require_signing'];
    signed = map['signed'];
    signedDate = map['signed_date'];
    signedBy = map['signed_by'];
    List tmpSubTasks = map['sub_tasks'];
    subTasks.clear();
    tmpSubTasks.forEach((element) {
      subTasks.add(SubTask.fromMap(element));
    });
  }

  printInfo() {
    print(id + " " + title + " " + cooperativeID + " " + eventDate);
  }
}
