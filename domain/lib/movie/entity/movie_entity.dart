import 'movie_info_entity.dart';

sealed class MovieEntity {
  final List<MovieInfoEntity> results;

  MovieEntity._(this.results);
}

final class PopularMovieEntity extends MovieEntity {
  PopularMovieEntity({required List<MovieInfoEntity> results}) : super._(results);
}

final class NowPlayingMovieEntity extends MovieEntity {
  NowPlayingMovieEntity({required List<MovieInfoEntity> results}) : super._(results);
}

final class MovieCategoryEntity extends MovieEntity {
  MovieCategoryEntity({required List<MovieInfoEntity> results}) : super._(results);
}
