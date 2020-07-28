import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movies/features/movies/data/bloc/movie/search_result_bloc/movie_search_bloc.dart';
import 'package:movies/features/movies/data/datasource/movies_local_data_source.dart';
import 'package:movies/features/movies/data/repository/movies_repository.dart';
import 'package:movies/features/movies/data/repository/movies_repository_impl.dart';
import 'package:movies/features/movies/data/service/movie_api_service.dart';

import 'core/network_info.dart';
import 'features/movies/data/bloc/movie/movie_category/movie_bloc.dart';
import 'features/movies/data/bloc/movie/now_playing/now_playing_movie_bloc.dart';
import 'features/movies/data/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'features/movies/data/datasource/movies_remote_data_source.dart';
import 'features/movies/data/local/database/db/db_helper.dart';

final injector = GetIt.instance;

Future<void> init() async {
  //! Features - MovieBloc Bloc
  injector.registerFactory(() => MovieBloc(appRepository: injector.get()));

  injector.registerFactory(() => NowPlayingMovieBloc(appRepository: injector.get()));

  injector.registerFactory(() => PopularMovieBloc(appRepository: injector.get()));

  injector.registerFactory(() => MovieSearchBloc(appRepository: injector.get()));

  // Repository
  injector.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(remoteDataSource: injector.get(), localDataSource: injector.get(), networkInfo: injector.get()),
  );

  // Data sources
  injector.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSourceImpl(movieApiService: injector.get()),
  );

  injector.registerLazySingleton<MoviesLocalDataSource>(
    () => MoviesLocalDataSourceImpl(dbProvider: DBProvider.db),
  );

  //! Core
  injector.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(injector()));

  //! External
  injector.registerLazySingleton(() => http.Client());
  injector.registerLazySingleton(() => DataConnectionChecker());

  // injecting our MovieApiService
  injector.registerLazySingleton<MovieApiService>(
    () => MovieApiServiceImpl(),
  );
  // injecting our db
//  injector.registerSingleton(() => DBProvider.db);
}
