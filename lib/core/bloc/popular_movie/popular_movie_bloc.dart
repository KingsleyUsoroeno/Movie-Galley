import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/usecase/movies/fetch_popular_movies.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final FetchPopularMovie fetchPopularMovie;

  PopularMovieBloc({@required FetchPopularMovie fetchPopularMovie})
      : assert(fetchPopularMovie != null),
        fetchPopularMovie = fetchPopularMovie,
        super(InitialPopularMovieState());

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

  Stream<PopularMovieState> _fetchPopularMovies() async* {
    final failureOrMovie = await fetchPopularMovie.execute(false);
    yield failureOrMovie.fold(
        (failure) => PopularMovieError(errorMessage: failure.toString()),
        (r) => PopularMovieLoaded(popularMovie: r.first));
  }
}
