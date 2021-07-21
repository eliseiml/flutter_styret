import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_styret_app/domain/map_image.dart';
import 'package:flutter_styret_app/domain/map_layer.dart';
import 'package:flutter_styret_app/domain/map_object.dart';
import 'package:flutter_styret_app/domain/mmap.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/features/property_maps/domain/use_cases/get_map_objects_use_case.dart';
import 'package:flutter_styret_app/features/property_maps/domain/use_cases/save_image_use_case.dart';
import 'package:meta/meta.dart';

part 'floorplans_event.dart';
part 'floorplans_state.dart';

class FloorplansBloc extends Bloc<FloorplansEvent, FloorplansState> {
  final GetMapObjectsUseCase getMapObjectsUseCase;
  final SaveImageUseCase saveImageUseCase;

  FloorplansBloc({
    @required this.getMapObjectsUseCase,
    @required this.saveImageUseCase,
  }) : super(FloorplansInitial());

  FloorPlansLoadedState get getCurrentSelectionState => FloorPlansLoadedState(
        mapObjects: mapObjects,
        mmaps: mmaps,
        mapLayers: mapLayers,
        selectedMapObject: currentMapObject,
        selectedMMap: currentMMap,
        selectedMapLayer: currentMapLayer,
      );

  //Current state variables
  List<MapObject> mapObjects = [];
  List<MMap> mmaps = [];
  List<MapLayer> mapLayers = [];
  MapObject currentMapObject;
  MMap currentMMap;
  MapLayer currentMapLayer;

  @override
  Stream<FloorplansState> mapEventToState(
    FloorplansEvent event,
  ) async* {
    //Picker handlers

    //Pick MapObject
    if (event is PickMapObjectEvent) {
      currentMapObject = event.mapObject;
      mmaps = currentMapObject.mapList;
      currentMMap = mmaps.first;
      mapLayers = currentMMap.mapLayers;
      currentMapLayer = mapLayers.first;
      yield getCurrentSelectionState;
    }

    //Pick MMap
    if (event is PickMMapEvent) {
      currentMMap = event.mmap;
      mapLayers = currentMMap.mapLayers;
      currentMapLayer = mapLayers.first;
      yield getCurrentSelectionState;
    }

    //Pick MapLayer
    if (event is PickMapLayerEvent) {
      currentMapLayer = event.mapLayer;
      yield getCurrentSelectionState;
    }

    //Load floor plans
    if (event is LoadFloorPlansEvent) {
      yield LoadingFloorPlansState();
      mapObjects = await getMapObjectsUseCase(event.property);
      currentMapObject = mapObjects.first;
      mmaps = currentMapObject.mapList;
      currentMMap = mmaps.first;
      mapLayers = currentMMap.mapLayers;
      currentMapLayer = mapLayers.first;
      yield getCurrentSelectionState;
    }

    //Save image
    if (event is SaveImageEvent) {
      await saveImageUseCase(event.mapImage);
    }
  }
}
