import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/domain/map_object.dart';
import 'package:flutter_styret_app/features/property_maps/data/remote_sources/floor_plans_remote_source.dart';
import 'package:flutter_styret_app/features/property_maps/domain/repositories/floor_plans_repository.dart';
import 'package:meta/meta.dart';

class FloorPlansRepositoryImpl implements FloorPlansRepository {
  final FloorPlansRemoteSource floorPlansRemoteSource;

  FloorPlansRepositoryImpl({@required this.floorPlansRemoteSource});

  @override
  Future<List<MapObject>> getMapObjects(Property property) async {
    return await floorPlansRemoteSource.getMapObjects(property);
  }
}
