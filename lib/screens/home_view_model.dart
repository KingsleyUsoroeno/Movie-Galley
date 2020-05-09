import 'package:flutter/foundation.dart';
import 'package:movies/data/model/movies.dart';
import 'package:movies/data/model/network_response.dart';
import 'package:movies/data/model/now_playing.dart';
import 'package:movies/data/model/popular_movie.dart';
import 'package:movies/data/repository/app_repository.dart';

class HomeViewModel extends ChangeNotifier {
  NowPlayingResponse nowPlayingResponse;
  Movies movieResponse;
  PopularMovie popularMovieResponse;
  String messageToShow = "";
  final _appRepository = AppRepository();

  bool _isNowPlayingLoading = false;
  bool _isMovieResponseLoading = false;
  bool _isPopularMovieResponseLoading = false;

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
    NetworkResponse networkingResponse =
        await _appRepository.getMovieCategory();

    /// We check the type of response and update the required field
    if (networkingResponse is NetworkingResponseData) {
      /// Updating the APIResponseModel when success
      movieResponse = networkingResponse.dataResponse;
      //print("viewModel movieResponse is ${movieResponse.toString()}");
    } else if (networkingResponse is NetworkingException) {
      /// Updating the errorMessage when fails
      messageToShow = networkingResponse.message;
    }

    /// Stop the loader
    _isMovieResponseLoading = false;
    notifyListeners();
  }

  void getNowPlaying() async {
    /// Start showing the loader
    _isNowPlayingLoading = true;
    notifyListeners();

    /// Wait for response
    NetworkResponse networkingResponse =
        await _appRepository.getNowPlayingMovies();

    /// We check the type of response and update the required field
    if (networkingResponse is NetworkingResponseData) {
      /// Updating the APIResponseModel when success
      nowPlayingResponse = networkingResponse.dataResponse;
    } else if (networkingResponse is NetworkingException) {
      /// Updating the errorMessage when fails
      messageToShow = networkingResponse.message;
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
    NetworkResponse networkingResponse =
        await _appRepository.getPopularMovies();

    /// We check the type of response and update the required field
    if (networkingResponse is NetworkingResponseData) {
      /// Updating the APIResponseModel when success
      popularMovieResponse = networkingResponse.dataResponse;
      print("popular movies is $popularMovieResponse");
    } else if (networkingResponse is NetworkingException) {
      /// Updating the errorMessage when fails
      messageToShow = networkingResponse.message;
    }

    /// Stop the loader
    _isPopularMovieResponseLoading = false;
    notifyListeners();
  }
}
