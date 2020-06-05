import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/data/remote/model/movies.dart';
import 'package:movies/data/remote/wrapper/network_response.dart';
import 'package:movies/data/repository/app_repository.dart';

import 'movie_bloc_event.dart';
import 'movie_bloc_state.dart';

class MovieBloc extends Bloc<MovieBlocEvent, MovieBlocState> {
  final AppRepository _repository;

  MovieBloc({@required AppRepository appRepository})
      : assert(appRepository != null),
        _repository = appRepository;

  @override
  MovieBlocState get initialState => InitialMovieBlocState();

  @override
  Stream<MovieBlocState> mapEventToState(MovieBlocEvent event) async* {
    if (event is FetchMovies) {
      yield* _mapFetchMoviesToState();
    }
  }

  Stream<MovieBlocState> _mapFetchMoviesToState() async* {
    yield MovieLoading();
    yield* _fetchMovies();
  }

  Stream<MovieBlocState> _fetchMovies() async* {
    NetworkResponse networkingResponse = await _repository.getMovieCategory();
    if (networkingResponse is NetworkingResponseData) {
      yield MovieLoaded(networkingResponse.dataResponse as Movies);
    } else if (networkingResponse is NetworkingException) {
      yield MovieError(networkingResponse.message);
    }
  }
}
