import 'package:data/sources/movie/local_movie_cache_datasource.dart';
import 'package:data/sources/movie/movie_remote_datasource.dart';
import 'package:domain/domain_dependencies.dart';
import 'package:domain/utils/maybe_result.dart';

class MovieRepositoryImpl implements MovieRepository {
  final LocalMovieCacheDataSource movieCacheDatasource;
  final MovieRemoteDatasource remoteDatasource;

  MovieRepositoryImpl({required this.movieCacheDatasource, required this.remoteDatasource});

  @override
  Future<MaybeResult<MovieCategoryEntity>> fetchMovieCategories() async {
    try {
      final cachedMovies = movieCacheDatasource.fetchMovieCategory();
      if (cachedMovies.results.isNotEmpty) return MaybeResult.success(cachedMovies);

      final movies = await remoteDatasource.fetchMovieCategories();
      movieCacheDatasource.insert(movies);

      return MaybeResult.success(movies);
    } catch (exception, stackTrace) {
      return MaybeResult.failure(AppException(exception.toString(), stackTrace));
    }
  }

  @override
  Future<MaybeResult<NowPlayingMovieEntity>> fetchNowPlayingMovies({int page = 1}) async {
    try {
      final cachedMovies = movieCacheDatasource.fetchNowPlayingMovies();
      if (cachedMovies.results.isNotEmpty && page <= 1) return MaybeResult.success(cachedMovies);

      final movies = await remoteDatasource.fetchNowPlayingMovies(page: page);
      movieCacheDatasource.insert(movies);

      return MaybeResult.success(movies);
    } catch (exception, stackTrace) {
      return MaybeResult.failure(AppException(exception.toString(), stackTrace));
    }
  }

  @override
  Future<MaybeResult<PopularMovieEntity>> fetchPopularMovies({int page = 1}) async {
    try {
      final cachedMovies = movieCacheDatasource.fetchPopularMovies();
      if (cachedMovies.results.isNotEmpty && page <= 1) return MaybeResult.success(cachedMovies);

      final movies = await remoteDatasource.fetchPopularMovies(page: page);
      movieCacheDatasource.insert(movies);

      return MaybeResult.success(movies);
    } catch (exception, stackTrace) {
      return MaybeResult.failure(AppException(exception.toString(), stackTrace));
    }
  }

  @override
  Future<MaybeResult<List<MovieInfoEntity>>> searchMovie(int page, String query) async {
    try {
      final movies = await remoteDatasource.searchForMovie(query, page);

      return MaybeResult.success(movies);
    } catch (exception, stackTrace) {
      return MaybeResult.failure(AppException(exception.toString(), stackTrace));
    }
  }
}
