import 'package:movies/data/model/database/model/movie_model.dart';
import 'package:movies/data/model/database/model/now_playing_model.dart';
import 'package:movies/data/model/database/model/popular_movie_model.dart';

abstract class DatabaseWrapper {
  Future<int> saveMovie(MovieDatabaseModel movie);

  Future<int> updateMovie(MovieDatabaseModel movie);

  Future deleteAllMovies();

  Future<int> saveNowPlaying(NowPlayingDatabaseModel nowPlayingDatabaseModel);

  Future<int> updateNowPlaying(NowPlayingDatabaseModel nowPlaying);

  Future deleteAllNowPlaying();

  Future<int> savePopularMovies(PopularMoviesDatabaseModel popularMovies);

  Future deleteAllPopularMovies();

  Future<int> updatePopularMovies(PopularMoviesDatabaseModel nowPlaying);

  Future<List<MovieDatabaseModel>> getAllMovies();

  Future<List<NowPlayingDatabaseModel>> getAllNowPlaying();

  Future<List<PopularMoviesDatabaseModel>> getAllPopularMovies();
}
