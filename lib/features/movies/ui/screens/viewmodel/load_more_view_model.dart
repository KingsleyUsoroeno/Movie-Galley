import 'package:flutter/foundation.dart';

class LoadMoreViewModel extends ChangeNotifier {
//  bool _loadMore = false;
//
//  bool _didFetchNowPlaying = false;
//  bool _didFetchPopularMovies = false;
//  NowPlayingResponse _nowPlayingResponse;
//  PopularMovie _popularMovies;
//
//  bool get didFetchNowPlaying => _didFetchNowPlaying;
//
//  bool get didFetchPopularMovies => _didFetchPopularMovies;
//
//  String nowPlayingNetworkExceptionMessage = "";
//  String popularMoviesExceptionMessage = "";
//
//  bool get loadMore => _loadMore;
//
//  final _appRepository = RemoteMoviesRepository();
//
//  void loadMoreNowPlayingMovie({bool loadMore = false, List<Results> results}) async {
//    /// Start showing the loader
//    _loadMore = true;
//    notifyListeners();
//
//    /// Wait for response
//    NetworkResponse networkingResponse = await _appRepository.getNowPlayingMovies(loadMore: loadMore);
//
//    /// We check the type of response and update the required field
//    if (networkingResponse is NetworkingResponseData) {
//      _nowPlayingResponse = networkingResponse.dataResponse;
//      results.addAll(_nowPlayingResponse.results);
//      _didFetchNowPlaying = true;
//      notifyListeners();
//    } else if (networkingResponse is NetworkingException) {
//      /// Updating the errorMessage when fails
//      nowPlayingNetworkExceptionMessage = networkingResponse.message;
//      _didFetchNowPlaying = false;
//      notifyListeners();
//    }
//
//    /// Stop the loader
//    _loadMore = false;
//    notifyListeners();
//  }
//
//  void loadMorePopularMovies({bool loadMore = false, List<Results> results}) async {
//    /// Start showing the loader
//    _loadMore = true;
//    notifyListeners();
//
//    /// Wait for response
//    NetworkResponse networkingResponse = await _appRepository.getPopularMovies(loadMore: loadMore);
//
//    /// We check the type of response and update the required field
//    if (networkingResponse is NetworkingResponseData) {
//      _popularMovies = networkingResponse.dataResponse;
//      results.addAll(_popularMovies.results);
//      _didFetchPopularMovies = true;
//      notifyListeners();
//    } else if (networkingResponse is NetworkingException) {
//      /// Updating the errorMessage when fails
//      popularMoviesExceptionMessage = networkingResponse.message;
//      _didFetchPopularMovies = false;
//      notifyListeners();
//    }
//
//    /// Stop the loader
//    _loadMore = false;
//    notifyListeners();
//  }
}
