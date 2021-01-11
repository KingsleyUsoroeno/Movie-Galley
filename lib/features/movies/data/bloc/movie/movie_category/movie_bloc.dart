import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/error/failures.dart';

import '../../../local/database/model/movie_model.dart';
import '../../../repository/movies_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  /*Event is what you put in , state is what you get back*/
  final MovieRepository _movieRepository;

  MovieBloc({@required MovieRepository movieRepository})
      : assert(movieRepository != null),
        _movieRepository = movieRepository;

  @override
  MovieState get initialState => InitialMovieState();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMovies) {
      yield* _mapFetchMoviesToState();
    } else if (event is RefreshMovies) {
      _mapFetchMoviesToState();
    }
  }

  Stream<MovieState> _mapFetchMoviesToState() async* {
    yield MovieLoading();
    yield* _fetchMovies();
  }

  Stream<MovieState> _eitherLoadedOrErrorState(Either<Failure, MovieDatabaseModel> failureOrMovies) async* {
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

  Stream<MovieState> _fetchMovies() async* {
    final failureOrMovie = await _movieRepository.fetchAllMovieCategories();
    yield* _eitherLoadedOrErrorState(failureOrMovie);
  }

  Stream<MovieState> _fetchMoreMovies(bool loadMore) async* {
    final failureOrMovie = await _movieRepository.fetchAllMovieCategories();
    yield* _eitherLoadedOrErrorState(failureOrMovie);
  }
}
