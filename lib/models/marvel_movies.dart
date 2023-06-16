import 'dart:convert';
import 'package:marvel/constants/api_http.dart';
import '../configurations/app_configs.dart';
import '../constants/api_endpoints.dart';

class MarvelMovies {
  final String title;
  final String director;
  final String posterUrl;

  MarvelMovies(
      {required this.title, required this.director, required this.posterUrl});

  factory MarvelMovies.fromJson(Map<String, dynamic> json) {
    return MarvelMovies(
      title: json['title'],
      director: json['director'],
      posterUrl: json['posterUrl'],
    );
  }

  static Future<List<MarvelMovies>> fetchMovies() async {
    List<MarvelMovies> list = [];
    final res = await ApiHttp.get(
        '${AppConfigs.url}/${ApiEndpoints.movies}?limit=100&${AppConfigs.getMD5()}');

    if (res.statusCode == 200) {
      Map data = json.decode(utf8.decode(res.bodyBytes));

      // if (data['code'] == 200) {
      //   List result = data['data']['results'];
      //   list = result.map((e) => MarvelCharacters.fromJson(e)).toList();
      // }

      list = (data['results'] as List)
          .map((json) => MarvelMovies.fromJson(json))
          .toList();
      return list;
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}
