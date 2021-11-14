import 'package:data/model/movie_entity.dart';

abstract class MovieCache {
  Future<int> saveMovie(MovieEntity movie);

  Future<int> updateMovie(MovieEntity movie);

  Future<int> saveNowPlaying(MovieEntity movieEntity);

  Future<int> updateNowPlaying(MovieEntity movieEntity);

  Future<int> savePopularMovies(MovieEntity movieEntity);

  Future<int> updatePopularMovies(MovieEntity movieEntity);

  Future<List<MovieEntity>> getCachedMovies();

  Future<List<MovieEntity>> getCachedNowPlaying();

  Future<List<MovieEntity>> getCachedPopularMovies();
}
