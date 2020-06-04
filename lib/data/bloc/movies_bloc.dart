import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/data/bloc/movie_event.dart';
import 'package:movies/data/bloc/movie_state.dart';
import 'package:movies/data/model/database/db/db_helper.dart';
import 'package:movies/data/remote/model/movies.dart';
import 'package:movies/data/remote/model/now_playing.dart';
import 'package:movies/data/remote/model/popular_movie.dart';
import 'package:movies/data/remote/wrapper/network_response.dart';
import 'package:movies/data/repository/app_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final AppRepository _repository;
  final dbHelper = DBProvider.db;

  MovieBloc({@required AppRepository repository})
      : assert(repository != null),
        this._repository = repository;

  @override
  MovieState get initialState => MoviesEmpty();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
  }

  Stream<MovieState> _mapAppStartedToState() async* {
    yield MoviesLoading();
    yield* _getMovieCategory();
    yield* _getNowPlayingMovies();
    yield* _getPopularMovies();
  }

  Stream<MovieState> _getMovieCategory() async* {
    // Request Movies
    NetworkResponse response = await _repository.getMovieCategory();
    if (response is NetworkingResponseData) {
      yield MoviesCategoryLoaded(response.dataResponse as Movies);
    } else if (response is NetworkingException) {
      yield MoviesError("Failed to fetch your movies");
    }
  }

  Stream<MovieState> _getPopularMovies() async* {
    // Request popular movies
    NetworkResponse response = await _repository.getPopularMovies();
    if (response is NetworkingResponseData) {
      yield PopularMoviesLoaded(response.dataResponse as PopularMovie);
    } else if (response is NetworkingException) {
      yield MoviesError("Failed to fetch your movies");
    }
  }

  Stream<MovieState> _getNowPlayingMovies() async* {
    // Request popular movies
    NetworkResponse response = await _repository.getNowPlayingMovies();
    if (response is NetworkingResponseData) {
      yield NowPlayingMoviesLoaded(response.dataResponse as NowPlayingResponse);
    } else if (response is NetworkingException) {
      yield MoviesError("Failed to fetch your movies");
    }
  }

  void _saveMovieToDb(Movies movie) async {
    print("save movie to db called");
    int i = await dbHelper.saveMovie(movie.toDatabaseModel());
    print("new inserted movie rowId is $i");
  }

  void _savePopularMoviesToDb(PopularMovie popularMovies) async {
    print("save savePopularMoviesToDb to db called");
    int i = await dbHelper.savePopularMovies(popularMovies.toDatabaseModel());
    print("new inserted popular movie rowId is $i");
  }
}
