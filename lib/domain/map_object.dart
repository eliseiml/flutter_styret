import 'package:flutter_styret_app/domain/mmap.dart';
import 'package:meta/meta.dart';

class MapObject {
  final String id;
  final String title;
  final String propertyId;
  final String rank;
  final List<MMap> mapList;

  MapObject(
      {@required this.id,
      @required this.title,
      @required this.propertyId,
      @required this.rank,
      @required this.mapList});

  factory MapObject.fromMap(Map<String, dynamic> map) {
    return MapObject(
      id: map['id'],
      title: map['title'],
      propertyId: map['borettslag_id'],
      rank: map['rank'],
      mapList: mmapFromMap(map['MapList']),
    );
  }
}

List<MMap> mmapFromMap(List<dynamic> list) {
  List<MMap> result = [];
  list.forEach((element) {
    result.add(MMap.fromMap(element));
  });
  return result;
}
