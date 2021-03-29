import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/exception/failure.dart';
import 'package:domain/imports/module_imports.dart';
import 'package:domain/usecase/movies/search_movie.dart';
import 'package:meta/meta.dart';

import 'movie_search_event.dart';
import 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovie searchMovie;

  MovieSearchBloc({@required SearchMovie searchMovie})
      : assert(searchMovie != null),
        searchMovie = searchMovie,
        super(MovieSearchInitial());

  @override
  Stream<MovieSearchState> mapEventToState(MovieSearchEvent event) async* {
    if (event is SearchMovies) {
      yield* _mapFetchMoviesToState(event.movieQuery);
    }
  }

  Stream<MovieSearchState> _eitherLoadedOrErrorState(
      Either<Failure, Movie> failureOrMovies) async* {
    yield failureOrMovies.fold(
      (failure) => MovieSearchError(failure.toString()),
      (movie) => MovieSearchLoaded(movies: movie),
    );
  }

  Stream<MovieSearchState> _mapFetchMoviesToState(String movieQuery) async* {
    yield MovieSearchLoading();
    yield* _fetchMovies(movieQuery);
  }

  Stream<MovieSearchState> _fetchMovies(String movieQuery) async* {
    final failureOrMovie = await searchMovie
        .execute(SearchMovieParams(query: movieQuery, loadMore: false));
    yield* _eitherLoadedOrErrorState(failureOrMovie);
  }
}
