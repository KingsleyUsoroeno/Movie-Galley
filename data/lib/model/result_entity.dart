import 'package:meta/meta.dart';

class ResultEntity {
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

  ResultEntity({
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
}
