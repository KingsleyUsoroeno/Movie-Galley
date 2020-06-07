import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/features/movies/data/local/model/database/model/now_playing_movies_model.dart';
import 'package:movies/features/movies/data/remote/model/Result.dart';
import 'package:movies/features/movies/data/repository/movies_repository.dart';

import 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final MoviesRepository _repository;

  NowPlayingMoviesBloc({@required MoviesRepository appRepository})
      : assert(appRepository != null),
        _repository = appRepository;

  @override
  NowPlayingMoviesState get initialState => InitialNowPlayingMoviesState();

  @override
  Stream<NowPlayingMoviesState> mapEventToState(NowPlayingMoviesEvent event) async* {
    if (event is FetchNowPlayingMovies) {
      yield* _mapFetchNowPlayingMoviesToState();
    } else if (event is FetchMoreMovies) {
      yield* _mapLoadMoreMoviesToState(event);
    }
  }

  Stream<NowPlayingMoviesState> _mapFetchNowPlayingMoviesToState() async* {
    yield NowPlayingMovieLoading();
    yield* _fetchMovies();
  }

  Stream<NowPlayingMoviesState> _mapLoadMoreMoviesToState(FetchMoreMovies event) async* {
    //yield NowPlayingMovieLoading();
    yield* _fetchMoreMovies(event.loadMore);
  }

  Stream<NowPlayingMoviesState> _fetchMovies() async* {
    final failureOrMovie = await _repository.fetchAllNowPlayingMovies();
    yield* _eitherLoadedOrErrorState(failureOrMovie);
  }

  Stream<NowPlayingMoviesState> _fetchMoreMovies(bool loadMore) async* {
    final failureOrMovie = await _repository.fetchMoreNowPlayingMovies(loadMore: loadMore);
    yield* _eitherLoadedMoreMovieOrErrorState(failureOrMovie);
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

  Stream<NowPlayingMoviesState> _eitherLoadedOrErrorState(Either<Failure, NowPlayingMoviesDatabaseModel> failureOrMovies) async* {
    yield failureOrMovies.fold(
      (failure) => NowPlayingMovieError(errorMessage: _mapFailureToMessage(failure)),
      (movie) => NowPlayingMovieLoaded(nowPlayingMovies: movie),
    );
  }

  Stream<NowPlayingMoviesState> _eitherLoadedMoreMovieOrErrorState(Either<Failure, List<Results>> failureOrMovies) async* {
    yield failureOrMovies.fold(
      (failure) => NowPlayingMovieError(errorMessage: _mapFailureToMessage(failure)),
      (movie) => NowPlayingMovieLoadMore(movies: movie),
    );
  }
}
