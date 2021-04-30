class Films {
  List<Film> items = [];

  Films();

  Films.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final film = Film.fromJsonMap(item);
      items.add(film);
    }
  }
}

class Film {
  String posterPath;
  bool adult;
  String overview;
  String releaseDate;
  List<int> genreIds;
  int id;
  String originalTitle;
  String originalLanguage;
  String title;
  String backdropPath;
  double popularity;
  int voteCount;
  bool video;
  double voteAverage;

  Film({
    this.posterPath,
    this.adult,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.id,
    this.originalTitle,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.video,
    this.voteAverage,
  });

  Film.fromJsonMap(Map<String, dynamic> json) {
    posterPath = json["poster_path"];
    adult = json["adult"];
    overview = json["overview"];
    releaseDate = json["release_date"];
    genreIds = json["genre_ids"].cast<int>();
    id = json["id"];
    originalTitle = json["original_title"];
    originalLanguage = json["original_language"];
    title = json["title"];
    backdropPath = json["backdrop_path"];
    popularity = json["popularity"] / 1;
    voteCount = json["vote_count"];
    video = json["video"];
    voteAverage = json["vote_average"] / 1;
  }
}
