import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter_film_application/src/models/film_model.dart';

class FilmsProvider {
  String _apiKey = "f2f901c54a759c016b1baa7da9d6bb43";
  String _url = "api.themoviedb.org";
  String _lenguage = "es-ES";

  int _popularPages = 0;
  bool _loading = false;

  List<Film> _populars = [];

  final _popularsStreamController = StreamController<List<Film>>.broadcast();

  Function(List<Film>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Film>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

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
    if (_loading) return [];
    _loading = true;
    _popularPages++;

    final url = Uri.https(_url, "3/movie/popular", {
      "api_key": _apiKey,
      "language": _lenguage,
      "page": _popularPages.toString(),
    });

    final resp = await _processResponse(url);

    _populars.addAll(resp);
    popularsSink(_populars);

    _loading = false;

    return resp;
  }
}
