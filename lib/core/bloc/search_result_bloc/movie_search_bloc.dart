import 'package:bloc/bloc.dart';
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
      yield* _mapFetchMoviesToState(event.page, event.movieQuery);
    }
  }

  Stream<MovieSearchState> _mapFetchMoviesToState(
      int page, String movieQuery) async* {
    yield MovieSearchLoading();
    final failureOrMovie = await searchMovie.execute(
        SearchMovieParams(page: page, query: movieQuery, loadMore: false));
    yield failureOrMovie.fold(
      (failure) => MovieSearchError(failure.toString()),
      (movie) => MovieSearchLoaded(movies: movie),
    );
  }
}
