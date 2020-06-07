import 'package:movies/features/movies/data/local/model/database/model/movie_model.dart';
import 'package:movies/features/movies/data/local/model/database/model/now_playing_movies_model.dart';
import 'package:movies/features/movies/data/local/model/database/model/popular_movie_model.dart';

abstract class DatabaseWrapper {
  Future<int> saveMovie(MovieDatabaseModel movie);

  Future<int> updateMovie(MovieDatabaseModel movie);

  Future deleteAllMovies();

  Future<int> saveNowPlaying(NowPlayingMoviesDatabaseModel nowPlayingDatabaseModel);

  Future<int> updateNowPlaying(NowPlayingMoviesDatabaseModel nowPlaying);

  Future deleteAllNowPlaying();

  Future<int> savePopularMovies(PopularMoviesDatabaseModel popularMovies);

  Future deleteAllPopularMovies();

  Future<int> updatePopularMovies(PopularMoviesDatabaseModel nowPlaying);

  Future<List<MovieDatabaseModel>> getAllMovies();

  Future<List<NowPlayingMoviesDatabaseModel>> getAllNowPlaying();

  Future<List<PopularMoviesDatabaseModel>> getAllPopularMovies();
}
