import 'package:meta/meta.dart';

class CacheMovieResult {
  final dynamic popularity;
  final dynamic voteCount;
  final bool video;
  final String posterPath;
  final dynamic id;
  final bool adult;
  final String backdropPath;
  final String originalLanguage;
  final String originalTitle;
  final List<int> genreIds;
  final String title;
  final String overview;
  final String releaseDate;

  CacheMovieResult({
    @required this.popularity,
    @required this.voteCount,
    @required this.video,
    @required this.posterPath,
    @required this.id,
    @required this.adult,
    @required this.backdropPath,
    @required this.originalLanguage,
    @required this.originalTitle,
    @required this.genreIds,
    @required this.title,
    @required this.overview,
    @required this.releaseDate,
  });

  factory CacheMovieResult.fromJson(Map<String, dynamic> json) {
    return CacheMovieResult(
      popularity: json['popularity'],
      voteCount: json['vote_count'],
      video: json['video'],
      posterPath: json['poster_path'],
      id: json['id'],
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      genreIds: json['genre_ids'].cast<int>(),
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['vote_count'] = this.voteCount;
    data['video'] = this.video;
    data['poster_path'] = this.posterPath;
    data['id'] = this.id;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['title'] = this.title;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }

  @override
  String toString() {
    return 'Results{_popularity: $popularity, _voteCount: $voteCount, '
        '_video: $video, _posterPath: $posterPath, _id: $id, '
        '_adult: $adult, _backdropPath: $backdropPath,'
        ' _originalLanguage: $originalLanguage, '
        '_originalTitle: $originalTitle, '
        '_genreIds: $genreIds, _title: $title,'
        ' _overview: $overview, _releaseDate: $releaseDate}';
  }
}
