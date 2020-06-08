import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/features/movies/data/local/database/model/popular_movie_model.dart';
import 'package:movies/features/movies/data/repository/movies_repository.dart';

import 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final MoviesRepository _repository;

  PopularMovieBloc({@required MoviesRepository appRepository})
      : assert(appRepository != null),
        _repository = appRepository;

  @override
  PopularMovieState get initialState => InitialPopularMovieState();

  @override
  Stream<PopularMovieState> mapEventToState(PopularMovieEvent event) async* {
    if (event is FetchPopularMovies) {
      yield* _mapFetchPopularMoviesToState();
    } else if (event is RefreshPopularMovies) {
      yield* _mapFetchPopularMoviesToState();
    }
  }

  Stream<PopularMovieState> _mapFetchPopularMoviesToState() async* {
    yield PopularMovieLoading();
    yield* _fetchPopularMovies();
  }

  Stream<PopularMovieState> _eitherLoadedOrErrorState(Either<Failure, PopularMoviesDatabaseModel> failureOrMovies) async* {
    yield failureOrMovies.fold(
      (failure) => PopularMovieError(errorMessage: _mapFailureToMessage(failure)),
      (movie) => PopularMovieLoaded(popularMovie: movie),
    );
  }

  Stream<PopularMovieState> _fetchPopularMovies() async* {
    final failureOrMovie = await _repository.fetchAllPopularMovies();
    yield* _eitherLoadedOrErrorState(failureOrMovie);
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
}
