import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/data/remote/model/now_playing.dart';
import 'package:movies/data/remote/wrapper/network_response.dart';
import 'package:movies/data/repository/app_repository.dart';

import './bloc.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final AppRepository _repository;

  NowPlayingMoviesBloc({@required AppRepository appRepository})
      : assert(appRepository != null),
        _repository = appRepository;

  @override
  NowPlayingMoviesState get initialState => InitialNowPlayingMoviesState();

  @override
  Stream<NowPlayingMoviesState> mapEventToState(NowPlayingMoviesEvent event) async* {
    if (event is FetchNowPlayingMovies) {
      yield* _mapFetchNowPlayingMoviesToState();
    }
    // Todo add event for load more
  }

  Stream<NowPlayingMoviesState> _mapFetchNowPlayingMoviesToState() async* {
    yield NowPlayingMovieLoading();
    yield* _fetchMovies();
  }

  Stream<NowPlayingMoviesState> _fetchMovies() async* {
    NetworkResponse networkingResponse = await _repository.getNowPlayingMovies();
    if (networkingResponse is NetworkingResponseData) {
      yield NowPlayingMovieLoaded(networkingResponse.dataResponse as NowPlayingResponse);
    } else if (networkingResponse is NetworkingException) {
      yield NowPlayingMovieError(networkingResponse.message);
    }
  }
}
