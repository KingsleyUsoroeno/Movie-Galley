import 'package:cache/db/db_helper.dart';
import 'package:cache/mapper/cache_movie_mapper.dart';
import 'package:data/contract/cache/movie_cache.dart';
import 'package:data/model/movie_entity.dart';
import 'package:meta/meta.dart';

class MovieCacheImpl implements MovieCache {
  final DatabaseHelper databaseHelper;
  final CacheMovieMapper cacheMovieMapper;

  MovieCacheImpl({
    @required this.databaseHelper,
    @required this.cacheMovieMapper,
  });

  @override
  Future<List<MovieEntity>> getCachedMovies() async {
    final cachedMovies = await databaseHelper.getAllMovies();
    return cacheMovieMapper.mapToEntityList(cachedMovies);
  }

  @override
  Future<List<MovieEntity>> getCachedNowPlaying() async {
    final movies = await databaseHelper.getAllNowPlaying();
    return cacheMovieMapper.mapToEntityList(movies);
  }

  @override
  Future<List<MovieEntity>> getCachedPopularMovies() async {
    final popularMovies = await databaseHelper.getAllPopularMovies();
    return cacheMovieMapper.mapToEntityList(popularMovies);
  }

  @override
  Future<int> saveMovie(MovieEntity movie) {
    return databaseHelper.saveMovie(cacheMovieMapper.mapToModel(movie));
  }

  @override
  Future<int> saveNowPlaying(MovieEntity movieEntity) {
    return databaseHelper
        .saveNowPlaying(cacheMovieMapper.mapToModel(movieEntity));
  }

  @override
  Future<int> savePopularMovies(MovieEntity movieEntity) {
    return databaseHelper
        .savePopularMovies(cacheMovieMapper.mapToModel(movieEntity));
  }

  @override
  Future<int> updateMovie(MovieEntity movie) {
    return databaseHelper.updateMovie(cacheMovieMapper.mapToModel(movie));
  }

  @override
  Future<int> updateNowPlaying(MovieEntity entity) {
    return databaseHelper.updateNowPlaying(cacheMovieMapper.mapToModel(entity));
  }

  @override
  Future<int> updatePopularMovies(MovieEntity entity) {
    return databaseHelper
        .updatePopularMovies(cacheMovieMapper.mapToModel(entity));
  }
}
