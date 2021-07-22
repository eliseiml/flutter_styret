import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styret_app/domain/map_image.dart';
import 'package:flutter_styret_app/domain/map_layer.dart';
import 'package:flutter_styret_app/domain/map_object.dart';
import 'package:flutter_styret_app/domain/mmap.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/features/property_maps/data/local_sources/image_local_source.dart';
import 'package:flutter_styret_app/features/property_maps/data/remote_sources/floor_plans_remote_source.dart';
import 'package:flutter_styret_app/features/property_maps/data/repositories/floor_plans_repository_impl.dart';
import 'package:flutter_styret_app/features/property_maps/data/repositories/image_repository_impl.dart';
import 'package:flutter_styret_app/features/property_maps/domain/use_cases/get_map_objects_use_case.dart';
import 'package:flutter_styret_app/features/property_maps/domain/use_cases/save_image_use_case.dart';
import 'package:flutter_styret_app/features/property_maps/presentation/bloc/floorplans_bloc.dart';
import 'package:flutter_styret_app/features/property_maps/presentation/widgets/dropdown_picker.dart';
import 'package:flutter_styret_app/features/property_maps/presentation/widgets/grid_tile.dart';
import 'package:flutter_styret_app/features/property_maps/presentation/widgets/tiles_grid_view.dart';
import 'package:flutter_styret_app/utilites/awesomeIcons.dart';
import 'package:flutter_styret_app/utilites/colors.dart';
import 'package:flutter_styret_app/utilites/textStyles.dart';
import 'package:flutter_styret_app/widgets/popupMenu.dart';
import 'package:flutter_styret_app/features/property_maps/presentation/widgets/scalable_image_view.dart';
import 'package:meta/meta.dart';

class FloorPlansPage extends StatefulWidget {
  final Property property;
  FloorPlansPage({@required this.property});
  FloorPlansPageState createState() => FloorPlansPageState(property: property);
}

class FloorPlansPageState extends State<FloorPlansPage> {
  final Property property;

  final _bloc = FloorplansBloc(
    getMapObjectsUseCase: GetMapObjectsUseCase(
      floorPlansRepository: FloorPlansRepositoryImpl(
        floorPlansRemoteSource: FloorPlansRemoteSourceImpl(),
      ),
    ),
    saveImageUseCase: SaveImageUseCase(
      imageRepository: ImageRepositoryImpl(
        imageLocalSource: ImageLocalSourceImpl(),
      ),
    ),
  );

  FloorPlansPageState({@required this.property});

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  void _onUpdatePressed() {
    _bloc.add(LoadFloorPlansEvent(property: property));
  }

  void _onMapObjectTap(MapObject mapObject) {
    _bloc.add(PickMapObjectEvent(mapObject: mapObject));
  }

  void _onMMaptap(MMap mmap) {
    _bloc.add(PickMMapEvent(mmap: mmap));
  }

  void _onMapLayerTap(MapLayer mapLayer) {
    _bloc.add(PickMapLayerEvent(mapLayer: mapLayer));
  }

  void _onSaveImagePressed(MapImage mapImage) {
    _bloc.add(SaveImageEvent(mapImage: mapImage));
  }

  @override
  Widget build(BuildContext context) {
    _onUpdatePressed();
    return BlocBuilder<FloorplansBloc, FloorplansState>(
      bloc: _bloc,
      builder: (context, state) {
        Widget content = Container();
        if (state is LoadingFloorPlansState) {
          content = Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FloorPlansLoadedState) {
          if (MediaQuery.of(context).orientation == Orientation.portrait)
            content = portraitModeContent(context, state);
          else
            content = landscapeModeContent(context, state);
        }
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: true,
            backgroundColor: kAccentColor,
            title: Text(property.name, style: kAppBarTitleTextStyle),
            actions: [
              IconButton(
                onPressed: _onUpdatePressed,
                icon: Icon(Icons.update),
              ),
              popUpMenu(context, () {}),
              Container(width: 20),
            ],
          ),
          body: content,
        );
      },
    );
  }

  Widget portraitModeContent(
      BuildContext context, FloorPlansLoadedState state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //MapObjects
          tilesGridView(
            context: context,
            items: List.generate(
              state.mapObjects.length,
              (index) => gridTile(
                context: context,
                text: state.mapObjects[index].title,
                state: state.selectedMapObject == state.mapObjects[index],
                onTap: () => _onMapObjectTap(state.mapObjects[index]),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text('Etg:'),
          ),
          //MMaps
          tilesGridView(
            context: context,
            items: List.generate(
              state.mmaps.length,
              (index) => gridTile(
                context: context,
                text: state.mmaps[index].title,
                state: state.selectedMMap == state.mmaps[index],
                onTap: () => _onMMaptap(state.mmaps[index]),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text('Type:'),
          ),
          //MapLayers
          tilesGridView(
            context: context,
            items: List.generate(
              state.mapLayers.length,
              (index) => gridTile(
                context: context,
                text: state.mapLayers[index].title,
                state: state.selectedMapLayer == state.mapLayers[index],
                onTap: () => _onMapLayerTap(state.mapLayers[index]),
              ),
            ),
          ),
          Divider(
            color: kInactiveColor,
            thickness: 1.5,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Portrait/Landscape mode switch
                rotateScreenButton(context),
                //Save image button
                saveImageButton(context, state),
              ],
            ),
          ),
          scalableImageView(state.selectedMapLayer.mapImage.image)
        ],
      ),
    );
  }

  Widget landscapeModeContent(
      BuildContext context, FloorPlansLoadedState state) {
    return Column(
      children: [
        //Selection controls
        Padding(
          padding: const EdgeInsets.only(left: 60, right: 60, top: 10),
          child: Row(
            children: [
              //mapObject
              dropdownPicker(
                context: context,
                items: state.mapObjects,
                value: state.selectedMapObject,
                onChanged: (val) {
                  _onMapObjectTap(val);
                },
              ),
              //MMap
              dropdownPicker(
                context: context,
                items: state.selectedMapObject.mapList,
                value: state.selectedMMap,
                onChanged: (val) {
                  _onMMaptap(val);
                },
              ),
              //MapLayer
              dropdownPicker(
                context: context,
                items: state.selectedMMap.mapLayers,
                value: state.selectedMapLayer,
                onChanged: (val) {
                  _onMapLayerTap(val);
                },
              ),
              Spacer(),
              //Rotate button
              rotateScreenButton(context),
              //Save image button
              saveImageButton(context, state),
            ],
          ),
        ),
        //Image
        Expanded(
            child: scalableImageView(state.selectedMapLayer.mapImage.image))
      ],
    );
  }

  Widget rotateScreenButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.landscapeRight]);
          }
          if (MediaQuery.of(context).orientation == Orientation.landscape) {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.portraitUp]);
          }
        },
        icon: AwesomeIcon(
          icon: AwesomeIcons.rotateIcon,
          fontFamily: 'fa-solid',
          color: kAccentColor,
        ));
  }

  Widget saveImageButton(BuildContext context, FloorPlansLoadedState state) {
    return IconButton(
        onPressed: () {
          _onSaveImagePressed(state.selectedMapLayer.mapImage);
        },
        icon: AwesomeIcon(
          icon: AwesomeIcons.downloadIcon,
          fontFamily: 'fa-solid',
          color: kAccentColor,
        ));
  }
}
