import 'package:flutter_styret_app/domain/map_image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

abstract class ImageLocalSource {
  Future<bool> saveImage(MapImage image);
}

class ImageLocalSourceImpl implements ImageLocalSource {
  @override
  Future<bool> saveImage(MapImage image) async {
    String timeStamp = DateTime.now().hour.toString() +
        '-' +
        DateTime.now().minute.toString() +
        '-' +
        DateTime.now().second.toString();
    try {
      if (await Permission.storage.request().isGranted) {
        var response = await http.readBytes(Uri.parse(image.image));
        var result = await ImageGallerySaver.saveImage(
          response,
          name: '${image.id}-$timeStamp',
        );
        print(result['isSuccess']);
        return result['isSuccess'];
      } else {
        print('Permission is NOT GRANTED');
      }
    } catch (e) {
      print('Error saving file: $e');
    }
    return false;
  }
}
