part of 'floorplans_bloc.dart';

@immutable
abstract class FloorplansEvent {}

class LoadFloorPlansEvent extends FloorplansEvent {
  final Property property;
  LoadFloorPlansEvent({@required this.property});
}

class PickMapObjectEvent extends FloorplansEvent {
  final MapObject mapObject;

  PickMapObjectEvent({
    @required this.mapObject,
  });
}

class PickMMapEvent extends FloorplansEvent {
  final MMap mmap;

  PickMMapEvent({
    @required this.mmap,
  });
}

class PickMapLayerEvent extends FloorplansEvent {
  final MapLayer mapLayer;

  PickMapLayerEvent({
    @required this.mapLayer,
  });
}

class SaveImageEvent extends FloorplansEvent {
  final MapImage mapImage;

  SaveImageEvent({
    @required this.mapImage,
  });
}
