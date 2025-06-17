import 'package:data/repository/movie/movie_repository_impl.dart';
import 'package:data/sources/movie/local_movie_cache_datasource.dart';
import 'package:domain/domain_dependencies.dart';
import 'package:domain/movie/use_case/search_movie_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movies/movies/movie_categories/cubit/movie_category_cubit.dart';
import 'package:movies/movies/movie_search/cubit/movie_search_cubit.dart';
import 'package:movies/movies/now_playing_movies/cubit/now_playing_movies_cubit.dart';
import 'package:movies/movies/popular_movies/cubit/popular_movies_cubit.dart';
import 'package:remote/sources/movies/movie_remote_datasource_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;

Future<void> init() async {
  final sharedPref = await SharedPreferences.getInstance();

  injector.registerFactory(() => FetchNowPlayingMovieUseCase(movieRepository: injector.get()));

  injector.registerFactory(() => FetchMovieCategoriesUseCase(movieRepository: injector.get()));

  injector.registerFactory(() => SearchMovieUseCase(movieRepository: injector.get()));

  injector.registerFactory(() => FetchPopularMoviesUseCase(movieRepository: injector.get()));

  //! Features - MovieBloc Bloc
  injector.registerFactory(() => MovieCategoryCubit(fetchMovieCategoriesUseCase: injector.get()));

  injector.registerFactory(() => NowPlayingMoviesCubit(fetchNowPlayingMovieUseCase: injector.get()));

  injector.registerFactory(() => MovieSearchCubit(searchMovieUseCase: injector.get()));

  injector.registerFactory(() => PopularMoviesCubit(fetchNowPlayingMovieUseCase: injector.get()));

  // Repository
  injector.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      movieCacheDatasource: LocalMovieCacheDataSource(sharedPref),
      remoteDatasource: MovieRemoteDatasourceImpl(httpClient: http.Client()),
    ),
  );
}
