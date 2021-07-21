import 'package:flutter_styret_app/domain/map_object.dart';
import 'package:flutter_styret_app/domain/property.dart';

abstract class FloorPlansRepository {
  Future<List<MapObject>> getMapObjects(Property property);
}
