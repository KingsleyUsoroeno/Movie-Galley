import 'package:data/model/movie_entity.dart';

abstract class MovieRemote {
  Future<MovieEntity> fetchMovieCategories();

  Future<MovieEntity> fetchPopularMovies({int page});

  Future<MovieEntity> fetchNowPlayingMovies({int page});

  Future<MovieEntity> searchForMovie(String query, int page);
}
