class SubTask {
  String id;
  String type;
  String title;
  String desc;
  String standard;
  bool required;
  int rank;
  List options = [];
  String answer;
  String timestamp;
  int eventId;

  SubTask(
      {this.id,
      this.type,
      this.title,
      this.desc,
      this.standard,
      this.required,
      this.rank,
      this.options,
      this.answer,
      this.timestamp,
      this.eventId});

  factory SubTask.fromMap(Map<String, dynamic> map) {
    return SubTask(
        id: map['id'],
        type: map['type'],
        title: map['title'],
        desc: map['desc'],
        standard: map['standard'],
        required: map['required'],
        rank: map['rank'],
        options: map['options'],
        answer: map['answer'],
        timestamp: map['timestamp'],
        eventId: map['event_id']);
  }
}

/* Types
1. short_text 
2. long_text
3. number - numbers only
4. date - date picker
5. yes_no - checkbox (yes - checked)
6. yes_no_dunno - dropdown menu yes/no/doNotKnow (doNotKnow by default)
7. multiple_choice - dropdown menu (answers - options->choises)
8. image - take a picture (camera or gallery)
9. file - file picker
 */
