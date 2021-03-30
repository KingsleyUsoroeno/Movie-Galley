import 'package:data/model/movie_entity.dart';
import 'package:data/model/now_playing_movie_entity.dart';
import 'package:data/model/popular_movie_entity.dart';

abstract class MovieCache {
  Future<int> saveMovie(MovieEntity movie);

  Future<int> updateMovie(MovieEntity movie);

  Future deleteAllMovies();

  Future<int> saveNowPlaying(NowPlayingMovieEntity movieEntity);

  Future<int> updateNowPlaying(NowPlayingMovieEntity nowPlaying);

  Future deleteAllNowPlaying();

  Future<int> savePopularMovies(PopularMovieEntity popularMovies);

  Future deleteAllPopularMovies();

  Future<int> updatePopularMovies(PopularMovieEntity nowPlaying);

  Future<List<MovieEntity>> getAllMovies();

  Future<List<NowPlayingMovieEntity>> getAllNowPlaying();

  Future<List<PopularMovieEntity>> getAllPopularMovies();
}
