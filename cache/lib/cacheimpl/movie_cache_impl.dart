import 'package:cache/db/db_helper.dart';
import 'package:cache/mapper/cache_movie_mapper.dart';
import 'package:cache/mapper/cache_now_playing_movie_mapper.dart';
import 'package:data/contract/cache/movie_cache.dart';
import 'package:data/model/movie_entity.dart';
import 'package:data/model/now_playing_movie_entity.dart';
import 'package:data/model/popular_movie_entity.dart';

class MovieCacheImpl implements MovieCache {
  final DatabaseHelper databaseHelper;
  final CacheMovieMapper cacheMovieMapper;
  final CacheNowPlayingMovieMapper nowPlayingMovieMapper;

  MovieCacheImpl({
    this.databaseHelper,
    this.cacheMovieMapper,
    this.nowPlayingMovieMapper,
  });

  @override
  Future deleteAllMovies() {
    return databaseHelper.deleteAllMovies();
  }

  @override
  Future deleteAllNowPlaying() {
    return databaseHelper.deleteAllNowPlaying();
  }

  @override
  Future deleteAllPopularMovies() {
    return databaseHelper.deleteAllPopularMovies();
  }

  @override
  Future<List<MovieEntity>> getAllMovies() async {
    final cachedMovies = await databaseHelper.getAllMovies();
    if (cachedMovies != null && cachedMovies.isNotEmpty) {
      return cachedMovies.map((e) => cacheMovieMapper.mapToEntity(e)).toList();
    }
    return [];
  }

  @override
  Future<List<NowPlayingMovieEntity>> getAllNowPlaying() async {
    final cachedNowPlayingMovie = await databaseHelper.getAllNowPlaying();
    return cachedNowPlayingMovie
        .map((e) => nowPlayingMovieMapper.mapToEntity(e))
        .toList();
  }

  @override
  Future<List<PopularMovieEntity>> getAllPopularMovies() {
    // TODO: implement getAllPopularMovies
    throw UnimplementedError();
  }

  @override
  Future<int> saveMovie(MovieEntity movie) {
    print("saved movie is $movie");
    return databaseHelper.saveMovie(cacheMovieMapper.mapToModel(movie));
  }

  @override
  Future<int> saveNowPlaying(NowPlayingMovieEntity movie) {
    return databaseHelper
        .saveNowPlaying(nowPlayingMovieMapper.mapToModel(movie));
  }

  @override
  Future<int> savePopularMovies(PopularMovieEntity popularMovies) {
    // TODO: implement savePopularMovies
    throw UnimplementedError();
  }

  @override
  Future<int> updateMovie(MovieEntity movie) {
    return databaseHelper.updateMovie(cacheMovieMapper.mapToModel(movie));
  }

  @override
  Future<int> updateNowPlaying(NowPlayingMovieEntity entity) {
    return databaseHelper
        .updateNowPlaying(nowPlayingMovieMapper.mapToModel(entity));
  }

  @override
  Future<int> updatePopularMovies(PopularMovieEntity nowPlaying) {
    // TODO: implement updatePopularMovies
    throw UnimplementedError();
  }
}
