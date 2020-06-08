import 'package:meta/meta.dart';
import 'package:movies/core/error/exceptions.dart';
import 'package:movies/features/movies/data/local/database/db/db_helper.dart';
import 'package:movies/features/movies/data/local/database/model/movie_model.dart';
import 'package:movies/features/movies/data/local/database/model/now_playing_movies_model.dart';
import 'package:movies/features/movies/data/local/database/model/popular_movie_model.dart';
import 'package:movies/features/movies/data/remote/model/movies.dart';
import 'package:movies/features/movies/data/remote/model/now_playing.dart';
import 'package:movies/features/movies/data/remote/model/popular_movie.dart';

const String CACHE_EXCEPTION_MESSAGE = "No Data is Available in Cache";

abstract class MoviesLocalDataSource {
  /// Gets the cached [MovieDatabaseModel] which was gotten the last time
  /// as well as [NowPlayingMoviesDatabaseModel] and the [PopularMoviesDatabaseModel]
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.

  Future<MovieDatabaseModel> getMovieCategories();

  Future<NowPlayingMoviesDatabaseModel> getNowPlayingMovies();

  Future<PopularMoviesDatabaseModel> getPopularMovies();

  Future<void> cacheMovieCategory(Movies movies);

  Future<void> cacheNowPlayingMovies(NowPlayingResponse nowPlaying);

  Future<void> cachePopularMovies(PopularMovie popularMovie);

  Future<void> updateCacheNowPlayingMovies(NowPlayingMoviesDatabaseModel nowPlayingMovies);
}

class MoviesLocalDataSourceImpl implements MoviesLocalDataSource {
  final DBProvider dbProvider;

  MoviesLocalDataSourceImpl({@required this.dbProvider});

  @override
  Future<MovieDatabaseModel> getMovieCategories() async {
    final List<MovieDatabaseModel> movies = await dbProvider.getAllMovies();
    if (movies == null || movies.isEmpty) {
      throw CacheException(CACHE_EXCEPTION_MESSAGE);
    }
    return movies.first;
  }

  @override
  Future<NowPlayingMoviesDatabaseModel> getNowPlayingMovies() async {
    final List<NowPlayingMoviesDatabaseModel> nowPlayingMovies = await dbProvider.getAllNowPlaying();
    if (nowPlayingMovies == null || nowPlayingMovies.isEmpty) {
      throw CacheException(CACHE_EXCEPTION_MESSAGE);
    }
    return nowPlayingMovies.first;
  }

  @override
  Future<PopularMoviesDatabaseModel> getPopularMovies() async {
    final List<PopularMoviesDatabaseModel> popularMovies = await dbProvider.getAllPopularMovies();
    if (popularMovies == null || popularMovies.isEmpty) {
      throw CacheException(CACHE_EXCEPTION_MESSAGE);
    }
    return popularMovies.first;
  }

  @override
  Future<void> cacheMovieCategory(Movies movies) {
    return dbProvider.saveMovie(movies.toDatabaseModel());
  }

  @override
  Future<void> cacheNowPlayingMovies(NowPlayingResponse nowPlaying) {
    return dbProvider.saveNowPlaying(nowPlaying.toDatabaseModel());
  }

  @override
  Future<void> cachePopularMovies(PopularMovie popularMovie) {
    return dbProvider.savePopularMovies(popularMovie.toDatabaseModel());
  }

  @override
  Future<void> updateCacheNowPlayingMovies(NowPlayingMoviesDatabaseModel nowPlayingMovies) {
    return dbProvider.updateNowPlaying(nowPlayingMovies);
  }
}
