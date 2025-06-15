class MovieInfo {
  final bool adult;
  final String backdropPath;
  final String originalLanguage;
  final String originalTitle;
  final List<int> genreIds;
  final String title;
  final String overview;
  final String releaseDate;
  final bool video;
  final String posterPath;
  final dynamic popularity;
  final dynamic voteCount;
  final dynamic id;

  MovieInfo(
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.overview,
    this.releaseDate,
    this.video,
    this.posterPath,
    this.popularity,
    this.voteCount,
    this.id,
    this.adult,
  );

  factory MovieInfo.fromJson(Map<String, dynamic> json) {
    return MovieInfo(
      json['backdrop_path'],
      json['original_language'],
      json['original_title'],
      json['genre_ids'].cast<int>(),
      json['title'],
      json['overview'],
      json['release_date'],
      json['video'],
      json['poster_path'],
      json['popularity'],
      json['vote_count'],
      json['id'],
      json['adult'],
    );
  }
}
