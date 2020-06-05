import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/data/remote/model/popular_movie.dart';
import 'package:movies/data/remote/wrapper/network_response.dart';
import 'package:movies/data/repository/app_repository.dart';

import './bloc.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final AppRepository _repository;

  PopularMovieBloc({@required AppRepository appRepository})
      : assert(appRepository != null),
        _repository = appRepository;

  @override
  PopularMovieState get initialState => InitialPopularMovieState();

  @override
  Stream<PopularMovieState> mapEventToState(PopularMovieEvent event) async* {
    if (event is FetchPopularMovies) {
      yield* _mapFetchPopularMoviesToState();
    }
  }

  Stream<PopularMovieState> _mapFetchPopularMoviesToState() async* {
    yield PopularMovieLoading();
    yield* _fetchPopularMovies();
  }

  Stream<PopularMovieState> _fetchPopularMovies() async* {
    NetworkResponse networkingResponse = await _repository.getPopularMovies();
    if (networkingResponse is NetworkingResponseData) {
      yield PopularMovieLoaded(networkingResponse.dataResponse as PopularMovie);
    } else if (networkingResponse is NetworkingException) {
      yield PopularMovieError(networkingResponse.message);
    }
  }
}
