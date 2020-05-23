import 'package:flutter/foundation.dart';
import 'package:movies/data/model/database/db/db_helper.dart';
import 'package:movies/data/model/database/model/movie_model.dart';
import 'package:movies/data/model/database/model/now_playing_model.dart';
import 'package:movies/data/model/database/model/popular_movie_model.dart';
import 'package:movies/data/remote/model/movies.dart';
import 'package:movies/data/remote/model/now_playing.dart';
import 'package:movies/data/remote/model/popular_movie.dart';
import 'package:movies/data/remote/wrapper/network_response.dart';
import 'package:movies/data/repository/app_repository.dart';

class HomeViewModel extends ChangeNotifier {
  MovieDatabaseModel allMovies;
  PopularMoviesDatabaseModel allPopularMovies;
  NowPlayingDatabaseModel allNowPlayingMovies;
  final dbHelper = DBProvider.db;

  // DIFFERENT ERROR MESSAGES FOR THE VARIOUS LIST VIEWS ON THE UI
  String nowPlayingNetworkExceptionMessage = "";
  String popularMoviesNetworkExceptionMessage = "";
  String movieCategoryNetworkExceptionMessage = "";
  final _appRepository = AppRepository();

  // LOADING STATE OF THE DIFFERENT LIST VIEWS
  bool _isNowPlayingLoading = false;
  bool _isMovieResponseLoading = false;
  bool _isPopularMovieResponseLoading = false;

  // SUCCESS STATE OF THE DATA BEING FETCHED FROM THE NETWORK
  bool _didFetchMovieCategory = false;
  bool _didFetchPopularMovies = false;
  bool _didFetchNowPlaying = false;

  // GETTERS
  bool get didFetchMovieCategory => _didFetchMovieCategory;

  bool get didFetchPopularMovies => _didFetchPopularMovies;

  bool get didFetchNowPlaying => _didFetchNowPlaying;

  bool get isPopularMovieResponseLoading => _isPopularMovieResponseLoading;

  bool get isNowPlayingLoading => _isNowPlayingLoading;

  bool get isMovieResponseLoading => _isMovieResponseLoading;

  HomeViewModel() {
    _fetchMoviesAndSaveToDb();
    _fetchNowPlayingAndSaveToDb();
    _fetchPopularMoviesAndSaveToDb();
  }

  void _fetchMoviesAndSaveToDb() async {
    /// Start showing the loader
    _isMovieResponseLoading = true;
    notifyListeners();

    /// Wait for response
    NetworkResponse networkingResponse = await _appRepository.getMovieCategory();

    /// We check the type of response and update the required field
    if (networkingResponse is NetworkingResponseData) {
      _didFetchMovieCategory = true;
      // save all the movies to th db
      _saveMovieToDb(networkingResponse.dataResponse as Movies);
      notifyListeners();
    } else if (networkingResponse is NetworkingException) {
      /// Updating the errorMessage when fails
      movieCategoryNetworkExceptionMessage = networkingResponse.message;
      _didFetchMovieCategory = false;
      notifyListeners();
    }

    /// Stop the loader
    _isMovieResponseLoading = false;
    notifyListeners();
  }

  void _fetchNowPlayingAndSaveToDb() async {
    /// Start showing the loader
    _isNowPlayingLoading = true;
    notifyListeners();

    /// Wait for response
    NetworkResponse networkingResponse = await _appRepository.getNowPlayingMovies();

    if (networkingResponse is NetworkingResponseData) {
      _didFetchNowPlaying = true;
      _saveNowPlayingMoviesToDb(networkingResponse.dataResponse as NowPlayingResponse);
      notifyListeners();
    } else if (networkingResponse is NetworkingException) {
      /// Updating the errorMessage when fails
      nowPlayingNetworkExceptionMessage = networkingResponse.message;
      _didFetchNowPlaying = false;
      notifyListeners();
    }

    /// Stop the loader
    _isNowPlayingLoading = false;
    notifyListeners();
  }

  void _fetchPopularMoviesAndSaveToDb() async {
    /// Start showing the loader
    _isPopularMovieResponseLoading = true;
    notifyListeners();

    /// Wait for response
    NetworkResponse networkingResponse = await _appRepository.getPopularMovies();

    if (networkingResponse is NetworkingResponseData) {
      _didFetchPopularMovies = true;
      _savePopularMoviesToDb(networkingResponse.dataResponse as PopularMovie);
      notifyListeners();

      print("popular movies is ${networkingResponse.dataResponse as PopularMovie}");
    } else if (networkingResponse is NetworkingException) {
      /// Updating the errorMessage when fails
      popularMoviesNetworkExceptionMessage = networkingResponse.message;
      _didFetchPopularMovies = false;
      notifyListeners();
    }

    /// Stop the loader
    _isPopularMovieResponseLoading = false;
    notifyListeners();
  }

  void _saveMovieToDb(Movies movie) async {
    print("save movie to db called");
    int i = await dbHelper.saveMovie(movie.toDatabaseModel());
    print("new inserted movie rowId is $i");

    List<MovieDatabaseModel> allMovies = await dbHelper.getAllMovies();
    this.allMovies = allMovies.first;
    print("save movie to db movies are $allMovies");
    notifyListeners();
  }

  void _savePopularMoviesToDb(PopularMovie popularMovies) async {
    print("save savePopularMoviesToDb to db called");
    int i = await dbHelper.savePopularMovies(popularMovies.toDatabaseModel());
    print("new inserted popular movie rowId is $i");

    List<PopularMoviesDatabaseModel> allPopularMovies = await dbHelper.getAllPopularMovies();
    this.allPopularMovies = allPopularMovies.first;
    print("save allPopularMovies to db are $allPopularMovies");
    notifyListeners();
  }

  void _saveNowPlayingMoviesToDb(NowPlayingResponse nowPlayingResponse) async {
    print("save saveNowPlayingMoviesToDb called");
    int i = await dbHelper.saveNowPlaying(nowPlayingResponse.toDatabaseModel());
    print("new inserted now playing movie rowId is $i");

    List<NowPlayingDatabaseModel> allNowPlaying = await dbHelper.getAllNowPlaying();
    this.allNowPlayingMovies = allNowPlaying.first;
    print("save allPopularMovies to db are $allNowPlaying");
    notifyListeners();
  }
}
