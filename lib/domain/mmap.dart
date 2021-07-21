import 'package:flutter_styret_app/domain/map_layer.dart';
import 'package:meta/meta.dart';

class MMap {
  final String id;
  final String title;
  final String mapObjectId;
  final String hash;
  final String rank;
  final List<MapLayer> mapLayers;

  MMap(
      {@required this.id,
      @required this.title,
      @required this.mapObjectId,
      @required this.hash,
      @required this.rank,
      @required this.mapLayers});

  factory MMap.fromMap(Map<String, dynamic> map) {
    return MMap(
      id: map['id'],
      title: map['title'],
      mapObjectId: map['map_object_id'],
      hash: map['hash'],
      rank: map['rank'],
      mapLayers: mapLayerFromMap(map['MapLayer']),
    );
  }
}

List<MapLayer> mapLayerFromMap(List<dynamic> list) {
  List<MapLayer> result = [];
  list.forEach((element) {
    result.add(MapLayer.fromMap(element));
  });
  return result;
}
