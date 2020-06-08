import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/features/movies/data/local/database/model/movie_model.dart';
import 'package:movies/features/movies/data/repository/movies_repository.dart';

import 'movie_bloc_event.dart';
import 'movie_bloc_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class MovieBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final MoviesRepository _movieRepository;

  MovieBloc({@required MoviesRepository appRepository})
      : assert(appRepository != null),
        _movieRepository = appRepository;

  @override
  MovieBlocState get initialState => InitialMovieBlocState();

  @override
  Stream<MovieBlocState> mapEventToState(MovieBlocEvent event) async* {
    if (event is FetchMovies) {
      yield* _mapFetchMoviesToState();
    } else if (event is RefreshMovies) {
      _mapFetchMoviesToState();
    }
  }

  Stream<MovieBlocState> _mapFetchMoviesToState() async* {
    yield MovieLoading();
    yield* _fetchMovies();
  }

  Stream<MovieBlocState> _eitherLoadedOrErrorState(Either<Failure, MovieDatabaseModel> failureOrMovies) async* {
    yield failureOrMovies.fold(
      (failure) => MovieError(_mapFailureToMessage(failure)),
      (movie) => MovieLoaded(movie: movie),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

  Stream<MovieBlocState> _fetchMovies() async* {
    final failureOrMovie = await _movieRepository.fetchAllMovieCategories();
    yield* _eitherLoadedOrErrorState(failureOrMovie);
  }

  Stream<MovieBlocState> _fetchMoreMovies(bool loadMore) async* {
    final failureOrMovie = await _movieRepository.fetchAllMovieCategories();
    yield* _eitherLoadedOrErrorState(failureOrMovie);
  }
}
