import 'package:meta/meta.dart';

class MapImage {
  final String id;
  final String image;
  final String mapLayerId;
  final String mapListId;

  MapImage(
      {@required this.id,
      @required this.image,
      @required this.mapLayerId,
      @required this.mapListId});

  factory MapImage.fromMap(Map<String, dynamic> map) {
    return MapImage(
      id: map['id'],
      image: map['image'],
      mapLayerId: map['map_layer_id'],
      mapListId: map['map_list_id'],
    );
  }
}
