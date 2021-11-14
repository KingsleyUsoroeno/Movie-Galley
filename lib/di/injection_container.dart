import 'package:cache/cacheimpl/movie_cache_impl.dart';
import 'package:cache/db/db_helper.dart';
import 'package:cache/mapper/cache_movie_mapper.dart';
import 'package:data/contract/cache/movie_cache.dart';
import 'package:data/contract/remote/movie_remote.dart';
import 'package:data/mapper/movie_mapper.dart';
import 'package:data/repository/movie_repository_impl.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:domain/repository/movie_repository.dart';
import 'package:domain/usecase/movies/fetch_movie.dart';
import 'package:domain/usecase/movies/fetch_now_playing.dart';
import 'package:domain/usecase/movies/fetch_popular_movies.dart';
import 'package:domain/usecase/movies/search_movie.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movies/core/bloc/movie_category/bloc.dart';
import 'package:movies/core/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movies/utils/network_info.dart';
import 'package:remote/mapper/movie_remote_mapper.dart';
import 'package:remote/remote/movie_remote_impl.dart';

import '../core/bloc/movie_category/movie_bloc.dart';
import '../core/bloc/now_playing/now_playing_movie_bloc.dart';
import '../core/bloc/search_result_bloc/movie_search_bloc.dart';

final injector = GetIt.instance;

Future<void> init() async {
  //! Features - MovieBloc Bloc
  injector.registerFactory(() => MovieBloc(fetchMovie: injector.get()));

  injector.registerFactory(
      () => NowPlayingMovieBloc(fetchNowPlaying: injector.get()));

  injector.registerFactory(
    () => MovieSearchBloc(
      searchMovie: injector.get(),
    ),
  );

  injector.registerFactory(
    () => PopularMovieBloc(
      fetchPopularMovie: injector.get(),
    ),
  );

  // Repository
  injector.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      movieRemote: injector.get(),
      movieCache: injector.get(),
      movieMapper: MovieMapper(),
    ),
  );

  injector.registerLazySingleton<MovieCache>(
        () => MovieCacheImpl(
      databaseHelper: injector.get(),
      cacheMovieMapper: CacheMovieMapper(),
    ),
  );

  // injecting our MovieRemote
  injector.registerLazySingleton<MovieRemote>(
        () => MovieRemoteImpl(
      httpClient: http.Client(),
      movieRemoteMapper: MovieRemoteMapper(),
    ),
  );

  injector.registerLazySingleton(() => DatabaseHelper.db);

  injector
      .registerFactory(() => FetchNowPlaying(movieRepository: injector.get()));

  injector.registerFactory(() => FetchMovie(movieRepository: injector.get()));

  injector.registerFactory(() => SearchMovie(movieRepository: injector.get()));

  injector.registerFactory(
      () => FetchPopularMovie(movieRepository: injector.get()));

  injector
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(injector()));

  injector.registerLazySingleton(() => DataConnectionChecker());
}
