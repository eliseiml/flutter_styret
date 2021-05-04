class Discrepancy {
  String id;
  String title;
  String cooperativeId;
  String _improvementProgressStatus;
  String lastUpdated;
  String created;
  String responsibleUserId;
  String responsibleUserName;
  String vendorId;
  String vendorName;
  String dueDate;
  bool hasChanged;
  DateTime lastUpdatedDateTime;
  DateTime createdDateTime;
  DateTime dueDateTime;

  String get improvementProgressStatus {
    switch (_improvementProgressStatus) {
      case 'awaitOnImprovement':
        return 'Await on improvement';
        break;
      case 'awaitOnAccept':
        return 'Await on accept';
        break;
      case 'awaitOnSolution':
        return 'Await on solution';
        break;
      case 'discCreated':
        return 'Disc created';
        break;
      default:
        return 'Undefined status';
    }
  }

  Discrepancy(
      this.id,
      this.title,
      this.cooperativeId,
      this._improvementProgressStatus,
      this.lastUpdated,
      this.created,
      this.responsibleUserId,
      this.responsibleUserName,
      this.vendorId,
      this.vendorName,
      this.dueDate,
      this.hasChanged) {
    lastUpdatedDateTime = DateTime.parse(lastUpdated ?? '0000-00-00 00:00:00');
    createdDateTime = DateTime.parse(created ?? '0000-00-00 00:00:00');
    dueDateTime = DateTime.parse(dueDate ?? '0000-00-00 00:00:00');
    if (vendorName == '' || vendorName == null) {
      vendorName = '~Styret';
    }
  }

  factory Discrepancy.fromMap(Map<String, dynamic> map) {
    return Discrepancy(
      map['id'],
      map['title'],
      map['borettslag_id'],
      map['improvementProgressStatus'],
      map['last_updated'],
      map['created'],
      map['responsible_user_id'].toString(),
      map['responsible_user_name'],
      map['vendor_id'].toString(),
      map['vendor_name'],
      map['due_date'],
      map['has_changed'],
    );
  }
}
