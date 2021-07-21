import 'package:flutter_styret_app/domain/map_object.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/features/property_maps/domain/repositories/floor_plans_repository.dart';
import 'package:flutter_styret_app/features/property_maps/domain/use_cases/use_case.dart';
import 'package:meta/meta.dart';

class GetMapObjectsUseCase extends UseCase {
  final FloorPlansRepository floorPlansRepository;

  GetMapObjectsUseCase({@required this.floorPlansRepository});

  Future<List<MapObject>> call(Property property) async {
    return await floorPlansRepository.getMapObjects(property);
  }
}
