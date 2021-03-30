import 'package:cache/db/db_helper.dart';
import 'package:cache/mapper/cache_movie_mapper.dart';
import 'package:cache/mapper/cache_now_playing_movie_mapper.dart';
import 'package:cache/mapper/cache_popular_movie_mapper.dart';
import 'package:data/contract/cache/movie_cache.dart';
import 'package:data/model/movie_entity.dart';
import 'package:data/model/now_playing_movie_entity.dart';
import 'package:data/model/popular_movie_entity.dart';
import 'package:meta/meta.dart';

class MovieCacheImpl implements MovieCache {
  final DatabaseHelper databaseHelper;
  final CacheMovieMapper cacheMovieMapper;
  final CacheNowPlayingMovieMapper nowPlayingMovieMapper;
  final CachePopularMovieMapper popularMovieMapper;

  MovieCacheImpl({
    @required this.databaseHelper,
    @required this.cacheMovieMapper,
    @required this.nowPlayingMovieMapper,
    @required this.popularMovieMapper,
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
    return cacheMovieMapper.mapToEntityList(cachedMovies);
  }

  @override
  Future<List<NowPlayingMovieEntity>> getAllNowPlaying() async {
    final cachedNowPlayingMovie = await databaseHelper.getAllNowPlaying();
    return nowPlayingMovieMapper.mapToEntityList(cachedNowPlayingMovie);
  }

  @override
  Future<List<PopularMovieEntity>> getAllPopularMovies() async {
    final popularMovies = await databaseHelper.getAllPopularMovies();
    return popularMovieMapper.mapToEntityList(popularMovies);
  }

  @override
  Future<int> saveMovie(MovieEntity movie) {
    return databaseHelper.saveMovie(cacheMovieMapper.mapToModel(movie));
  }

  @override
  Future<int> saveNowPlaying(NowPlayingMovieEntity movie) {
    return databaseHelper
        .saveNowPlaying(nowPlayingMovieMapper.mapToModel(movie));
  }

  @override
  Future<int> savePopularMovies(PopularMovieEntity popularMovies) {
    return databaseHelper
        .savePopularMovies(popularMovieMapper.mapToModel(popularMovies));
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
  Future<int> updatePopularMovies(PopularMovieEntity entity) {
    return databaseHelper
        .updatePopularMovies(popularMovieMapper.mapToModel(entity));
  }
}
