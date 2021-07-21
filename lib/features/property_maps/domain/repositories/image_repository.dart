import 'package:flutter_styret_app/domain/map_image.dart';

abstract class ImageRepository {
  Future<bool> saveImage(MapImage image);
}
