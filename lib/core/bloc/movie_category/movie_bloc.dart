import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/exception/failure.dart';
import 'package:domain/usecase/movies/fetch_movie.dart';
import 'package:meta/meta.dart';

import 'movie_event.dart';
import 'movie_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final FetchMovie fetchMovie;

  MovieBloc({@required FetchMovie fetchMovie})
      : assert(fetchMovie != null),
        fetchMovie = fetchMovie,
        super(InitialMovieState());

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
    yield* _eitherLoadedOrErrorState();
  }

  Stream<MovieState> _eitherLoadedOrErrorState() async* {
    final failureOrMovie = await fetchMovie.execute("");
    yield failureOrMovie.fold(
      (l) => MovieError(_mapFailureToMessage(l)),
      (r) => MovieLoaded(movie: r.first),
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
}
