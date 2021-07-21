/* import 'package:flutter/material.dart';
import 'package:flutter_styret_app/features/property_maps/presentation/bloc/floorplans_bloc.dart';
import 'package:flutter_styret_app/features/property_maps/presentation/widgets/grid_tile.dart';
import 'package:flutter_styret_app/features/property_maps/presentation/widgets/tiles_grid_view.dart';
import 'package:meta/meta.dart';

Widget portraitFloorplansLayout({
  @required BuildContext context,
  @required FloorplansState state,
}) {
  return Column(
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
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: state.selectedMapLayer.mapImage.image != ''
            ? Image.network(
                state.selectedMapLayer.mapImage.image,
                loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return CircularProgressIndicator();
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.error,
                            size: 80,
                          );
                        },
              )
            : Icon(Icons.),
      )
    ],
  );
}
 */
