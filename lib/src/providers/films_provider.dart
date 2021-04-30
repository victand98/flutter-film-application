import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_film_application/src/models/film_model.dart';

class FilmsProvider {
  String _apiKey = "f2f901c54a759c016b1baa7da9d6bb43";
  String _url = "api.themoviedb.org";
  String _lenguage = "es-ES";

  Future<List<Film>> _processResponse(Uri url) async {
    final res = await http.get(url);
    final decodedData = json.decode(res.body);

    final films = Films.fromJsonList(decodedData["results"]);

    return films.items;
  }

  Future<List<Film>> getNowPlaying() async {
    final url = Uri.https(_url, "3/movie/now_playing", {
      "api_key": _apiKey,
      "language": _lenguage,
    });

    return await _processResponse(url);
  }

  Future<List<Film>> getPopulars() async {
    final url = Uri.https(_url, "3/movie/popular", {
      "api_key": _apiKey,
      "language": _lenguage,
    });

    return await _processResponse(url);
  }
}
