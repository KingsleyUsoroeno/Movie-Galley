import 'package:meta/meta.dart';

class MovieResult {
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

  MovieResult({
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

  factory MovieResult.fromJson(Map<String, dynamic> json) {
    return MovieResult(
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

  @override
  String toString() {
    return 'MovieResult{_popularity: $popularity, _voteCount: $voteCount, '
        '_video: $video, _posterPath: $posterPath, _id: $id, '
        '_adult: $adult, _backdropPath: $backdropPath,'
        ' _originalLanguage: $originalLanguage, '
        '_originalTitle: $originalTitle, '
        '_genreIds: $genreIds, _title: $title,'
        ' _overview: $overview, _releaseDate: $releaseDate}';
  }
}
