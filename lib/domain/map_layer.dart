import 'package:flutter/material.dart';
import 'package:flutter_styret_app/domain/map_image.dart';
import 'package:meta/meta.dart';

class MapLayer {
  final String id;
  final String title;
  final String mapObjectId;
  final MapImage mapImage;

  MapLayer(
      {@required this.id,
      @required this.title,
      @required this.mapObjectId,
      @required this.mapImage});

  factory MapLayer.fromMap(Map<String, dynamic> map) {
    return MapLayer(
      id: map['id'],
      title: map['title'],
      mapObjectId: map['map_object_id'],
      mapImage: MapImage.fromMap(map['mapImage']),
    );
  }
}
