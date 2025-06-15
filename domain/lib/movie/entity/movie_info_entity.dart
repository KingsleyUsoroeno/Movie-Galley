import 'package:equatable/equatable.dart';

class MovieInfoEntity extends Equatable {
  final bool adult;
  final String backdropPath;
  final String originalLanguage;
  final String originalTitle;
  final List<int> genreIds;
  final String title;
  final String overview;
  final String releaseDate;
  final bool video;
  final String? posterPath;
  final dynamic popularity;
  final dynamic voteCount;
  final dynamic id;

  MovieInfoEntity(
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

  String get moviePosterUrl => switch (posterPath) {
    null || '' =>
      'https://i0.wp.com/asiatimes.com/wp-content/uploads/2020/03/Screen-Shot-2020-03-02-at-11.37.50-AM.png?fit=850%2C486&ssl=1',
    _ => 'https://image.tmdb.org/t/p/w500/$posterPath',
  };

  factory MovieInfoEntity.fromJson(Map<String, dynamic> json) {
    return MovieInfoEntity(
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['popularity'] = popularity;
    data['vote_count'] = voteCount;
    data['video'] = video;
    data['poster_path'] = posterPath;
    data['id'] = id;
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['genre_ids'] = genreIds;
    data['title'] = title;
    data['overview'] = overview;
    data['release_date'] = releaseDate;
    return data;
  }

  @override
  List<Object?> get props => [];
}
