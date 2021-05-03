class Event {
  String id;
  String title;
  String cooperativeID;
  String eventDate;
  DateTime dateTime;

  Event(this.id, this.title, this.cooperativeID, this.eventDate) {
    dateTime = DateTime.parse(eventDate);
  }

  factory Event.fromMap(Map<String, dynamic> json) {
    return Event(
        json['id'], json['title'], json['borettslag_id'], json['event_date']);
  }

  printInfo() {
    print(id + " " + title + " " + cooperativeID + " " + eventDate);
  }
}
