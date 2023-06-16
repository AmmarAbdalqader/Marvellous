import 'dart:convert';
import 'package:marvel/models/marvel_thumbnail.dart';

import '../configurations/app_configs.dart';
import '../constants/api_endpoints.dart';
import '../constants/api_http.dart';

class MarvelSeries {
  final String title;
  final int id;
  final Thumbnail thumbnail;

  MarvelSeries(
      {required this.title, required this.id, required this.thumbnail});

  factory MarvelSeries.fromJson(Map<String, dynamic> json) {
    return MarvelSeries(
      title: json['title'],
      id: json['id'],
      thumbnail: Thumbnail.fromJson(json['thumbnail']),
    );
  }

  static Future<List<MarvelSeries>> fetchSeries() async {
    List<MarvelSeries> list = [];
    final res = await ApiHttp.get(
        '${AppConfigs.url}/${ApiEndpoints.series}?limit=100&${AppConfigs.getMD5()}');

    // final response = await http.get(url);

    // if (res.statusCode == 200) {
    //   final data = jsonDecode(response.body);
    //   final series = (data['results'] as List).map((json) => Series.fromJson(json)).toList();
    //   return series;
    // } else {
    //   throw Exception('Failed to fetch series');
    // }

    if (res.statusCode == 200) {
      Map data = json.decode(utf8.decode(res.bodyBytes));

      if (data['code'] == 200) {
        List result = data['data']['results'];
        list = result.map((e) => MarvelSeries.fromJson(e)).toList();
      }

      // list = (data['results'] as List)
      //     .map((json) => MarvelSeries.fromJson(json))
      //     .toList();
      return list;
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}
