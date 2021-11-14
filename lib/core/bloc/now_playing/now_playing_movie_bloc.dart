import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/exception/failure.dart';
import 'package:domain/imports/module_imports.dart';
import 'package:domain/usecase/movies/fetch_now_playing.dart';
import 'package:meta/meta.dart';

import 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final FetchNowPlaying fetchNowPlaying;

  NowPlayingMovieBloc({@required FetchNowPlaying fetchNowPlaying})
      : assert(fetchNowPlaying != null),
        fetchNowPlaying = fetchNowPlaying,
        super(InitialNowPlayingMoviesState());

  @override
  Stream<NowPlayingMoviesState> mapEventToState(
      NowPlayingMoviesEvent event) async* {
    if (event is FetchNowPlayingMovies) {
      yield* _mapFetchNowPlayingMoviesToState();
    } else if (event is FetchMoreMovies) {
      yield* _mapLoadMoreMoviesToState(event);
    } else if (event is RefreshNowPlayingMovies) {
      yield* _mapFetchNowPlayingMoviesToState();
    }
  }

  Stream<NowPlayingMoviesState> _mapFetchNowPlayingMoviesToState() async* {
    yield NowPlayingMovieLoading();
    yield* _fetchMovies();
  }

  Stream<NowPlayingMoviesState> _mapLoadMoreMoviesToState(
      FetchMoreMovies event) async* {
    //yield NowPlayingMovieLoading();
    // uncomment if you want to be notified of a loading indicator on the UI
    yield* _fetchMoreMovies(event.loadMore);
  }

  Stream<NowPlayingMoviesState> _fetchMovies() async* {
    final failureOrMovie = await fetchNowPlaying.execute(false);
    yield* _eitherLoadedOrErrorState(failureOrMovie);
  }

  Stream<NowPlayingMoviesState> _fetchMoreMovies(bool loadMore) async* {
    final failureOrMovie = await fetchNowPlaying.execute(loadMore);
    yield* _eitherLoadedOrErrorState(failureOrMovie);
  }

  Stream<NowPlayingMoviesState> _eitherLoadedOrErrorState(
      Either<Failure, List<Movie>> failureOrMovies) async* {
    yield failureOrMovies.fold(
      (failure) => NowPlayingMovieError(errorMessage: failure.toString()),
      (movie) {
        return NowPlayingMovieLoaded(nowPlayingMovies: movie.first);
      },
    );
  }
}
