class Movie {
  int id;
  String title;
  String backDropPath;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  double voteAverage;
  String youtubeTrailerUrl;

  Movie({
    required this.id,
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.youtubeTrailerUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final youtubeKey = json['title'] ?? ''; // Replace with actual field name
    final youtubeTrailerUrl = 'https://www.youtube.com/watch?v=$youtubeKey';
    return Movie(
        id: json["id"],
        title: json["title"],
        backDropPath: json["backdrop_path"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        voteAverage: json["vote_average"].toDouble(),
        youtubeTrailerUrl: youtubeTrailerUrl);
  }
}
