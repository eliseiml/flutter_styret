import 'dart:convert';

import 'package:flutter_styret_app/domain/map_object.dart';
import 'package:flutter_styret_app/domain/property.dart';
import 'package:flutter_styret_app/domain/user.dart';
import 'package:http/http.dart' as http;

abstract class FloorPlansRemoteSource {
  Future<List<MapObject>> getMapObjects(Property property);
}

class FloorPlansRemoteSourceImpl implements FloorPlansRemoteSource {
  static const String uri = 'secure.styret.com';
  @override
  Future<List<MapObject>> getMapObjects(Property property) async {
    String mapsEndpoint = 'api/v2/properties/${property.id}/maps';
    var response = await http.get(
      Uri.https(uri, mapsEndpoint),
      headers: {
        'token': '${user.token}',
        'X-Requested-With': 'XMLHttpRequest',
      },
    );
    if (response == null || response.statusCode != 200) return [];
    List<MapObject> result = [];
    /* jsonDecode(response.body)['data']
        .cast((e) => MapObject.fromMap(e['MapObject'])); */
    var resp = jsonDecode(response.body)['data'];
    resp.forEach((e) {
      result.add(MapObject.fromMap(e['MapObject']));
    });
    property.mapObjects = result;
    return result;
  }
}
