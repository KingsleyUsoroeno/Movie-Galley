import 'package:flutter/foundation.dart';
import 'package:movies/data/model/Result.dart';
import 'package:movies/data/model/movies.dart';
import 'package:movies/data/model/network_response.dart';
import 'package:movies/data/model/now_playing.dart';
import 'package:movies/data/model/popular_movie.dart';
import 'package:movies/data/repository/app_repository.dart';

class HomeViewModel extends ChangeNotifier {
  NowPlayingResponse nowPlayingResponse;
  Movies movieResponse;
  PopularMovie popularMovieResponse;

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

  bool get didFetchMovieCategory => _didFetchMovieCategory;

  bool get didFetchPopularMovies => _didFetchPopularMovies;

  bool get didFetchNowPlaying => _didFetchNowPlaying;

  bool get isPopularMovieResponseLoading => _isPopularMovieResponseLoading;

  bool get isNowPlayingLoading => _isNowPlayingLoading;

  bool get isMovieResponseLoading => _isMovieResponseLoading;

  HomeViewModel() {
    getMovieResponse();
    getNowPlaying();
    getPopularMovies();
  }

  void getMovieResponse() async {
    /// Start showing the loader
    _isMovieResponseLoading = true;
    notifyListeners();

    /// Wait for response
    NetworkResponse networkingResponse = await _appRepository.getMovieCategory();

    /// We check the type of response and update the required field
    if (networkingResponse is NetworkingResponseData) {
      /// Updating the APIResponseModel when success
      movieResponse = networkingResponse.dataResponse;
      _didFetchMovieCategory = true;
      notifyListeners();
      //print("viewModel movieResponse is ${movieResponse.toString()}");
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

  void getNowPlaying({bool loadMore = false, List<Results> results}) async {
    /// Start showing the loader
    _isNowPlayingLoading = true;
    notifyListeners();

    /// Wait for response
    NetworkResponse networkingResponse = await _appRepository.getNowPlayingMovies(loadMore: loadMore);

    /// We check the type of response and update the required field
    if (networkingResponse is NetworkingResponseData) {
      /// Updating the APIResponseModel when success
      nowPlayingResponse = networkingResponse.dataResponse;
      _didFetchNowPlaying = true;
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

  void getPopularMovies() async {
    /// Start showing the loader
    _isPopularMovieResponseLoading = true;
    notifyListeners();

    /// Wait for response
    NetworkResponse networkingResponse = await _appRepository.getPopularMovies();

    /// We check the type of response and update the required field
    if (networkingResponse is NetworkingResponseData) {
      /// Updating the APIResponseModel when success
      popularMovieResponse = networkingResponse.dataResponse;
      _didFetchPopularMovies = true;
      notifyListeners();
      print("popular movies is $popularMovieResponse");
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
}
