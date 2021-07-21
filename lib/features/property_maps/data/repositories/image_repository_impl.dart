import 'package:flutter_styret_app/domain/map_image.dart';
import 'package:flutter_styret_app/features/property_maps/data/local_sources/image_local_source.dart';
import 'package:flutter_styret_app/features/property_maps/domain/repositories/image_repository.dart';
import 'package:meta/meta.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageLocalSource imageLocalSource;

  ImageRepositoryImpl({@required this.imageLocalSource});

  @override
  Future<bool> saveImage(MapImage image) async {
    return await imageLocalSource.saveImage(image);
  }
}
