import 'package:flutter_styret_app/domain/map_image.dart';
import 'package:flutter_styret_app/features/property_maps/domain/repositories/image_repository.dart';
import 'package:flutter_styret_app/features/property_maps/domain/use_cases/use_case.dart';
import 'package:meta/meta.dart';

class SaveImageUseCase extends UseCase {
  final ImageRepository imageRepository;

  SaveImageUseCase({@required this.imageRepository});

  Future<bool> call(MapImage mapImage) async {
    return await imageRepository.saveImage(mapImage);
  }
}
