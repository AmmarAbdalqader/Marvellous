import 'dart:convert';
import 'dart:developer';
import 'package:marvel/configurations/app_configs.dart';
import 'package:marvel/constants/api_endpoints.dart';
import 'package:marvel/constants/api_http.dart';
import 'marvel_thumbnail.dart';

class MarvelCharacters {
  final int? id;
  final String? name;
  final String? description;
  final Thumbnail? thumbnail;

  MarvelCharacters({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
  });

  factory MarvelCharacters.fromJson(Map json) => MarvelCharacters(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        thumbnail: Thumbnail.fromJson(json['thumbnail']),
        // images: List.from(json['similars'] as List)
        //     .map((e) => MarvelImages.fromJson(e))
        //     .toList(),
      );

  static Future<List<MarvelCharacters>> fetchCharacters() async {
    List<MarvelCharacters> list = [];
    try {
      var res = await ApiHttp.get(
          "${AppConfigs.url}/${ApiEndpoints.characters}?limit=100&${AppConfigs.getMD5()}");
      if (res.statusCode == 200) {
        Map data = json.decode(utf8.decode(res.bodyBytes));
        if (data['code'] == 200) {
          List result = data['data']['results'];
          list = result.map((e) => MarvelCharacters.fromJson(e)).toList();
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return list;
  }
}
