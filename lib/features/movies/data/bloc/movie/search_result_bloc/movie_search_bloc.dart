import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/features/movies/data/bloc/movie/movie_category/movie_bloc.dart';
import 'package:movies/features/movies/data/bloc/movie/search_result_bloc/bloc.dart';
import 'package:movies/features/movies/data/remote/model/movies.dart';
import 'package:movies/features/movies/data/repository/movies_repository.dart';

import 'movie_search_event.dart';
import 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final MovieRepository _movieRepository;

  MovieSearchBloc({@required MovieRepository appRepository})
      : assert(appRepository != null),
        _movieRepository = appRepository;

  @override
  MovieSearchState get initialState => MovieSearchInitial();

  @override
  Stream<MovieSearchState> mapEventToState(MovieSearchEvent event) async* {
    if (event is SearchMovies) {
      yield* _mapFetchMoviesToState(event.movieQuery);
    }
  }

  Stream<MovieSearchState> _eitherLoadedOrErrorState(Either<Failure, Movies> failureOrMovies) async* {
    yield failureOrMovies.fold(
      (failure) => MovieSearchError(_mapFailureToMessage(failure)),
      (movie) => MovieSearchLoaded(movies: movie),
    );
  }

  Stream<MovieSearchState> _mapFetchMoviesToState(String movieQuery) async* {
    yield MovieSearchLoading();
    yield* _fetchMovies(movieQuery);
  }

  Stream<MovieSearchState> _fetchMovies(String movieQuery) async* {
    final failureOrMovie = await _movieRepository.searchForMovie(movieQuery);
    yield* _eitherLoadedOrErrorState(failureOrMovie);
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        final serverFailure = failure.runtimeType as ServerFailure;
        return SERVER_FAILURE_MESSAGE + " ${serverFailure.errorMessage}";
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error $failure';
    }
  }
}
