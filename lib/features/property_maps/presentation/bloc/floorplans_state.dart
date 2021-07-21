part of 'floorplans_bloc.dart';

@immutable
abstract class FloorplansState {}

class FloorplansInitial extends FloorplansState {}

class LoadingFloorPlansState extends FloorplansState {}

class FloorPlansLoadedState extends FloorplansState {
  final List<MapObject> mapObjects;
  final List<MMap> mmaps;
  final List<MapLayer> mapLayers;
  final MapObject selectedMapObject;
  final MMap selectedMMap;
  final MapLayer selectedMapLayer;

  FloorPlansLoadedState(
      {@required this.mapObjects,
      @required this.mmaps,
      @required this.mapLayers,
      @required this.selectedMapObject,
      @required this.selectedMMap,
      @required this.selectedMapLayer});
}
