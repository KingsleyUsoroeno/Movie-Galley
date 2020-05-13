import 'package:flutter/foundation.dart';
import 'package:movies/data/model/Result.dart';
import 'package:movies/data/model/network_response.dart';
import 'package:movies/data/model/now_playing.dart';
import 'package:movies/data/repository/app_repository.dart';

class LoadMoreViewModel extends ChangeNotifier {
  bool _loadMore = false;
  bool _didFetchNowPlaying = false;
  NowPlayingResponse _nowPlayingResponse;

  bool get didFetchNowPlaying => _didFetchNowPlaying;
  String nowPlayingNetworkExceptionMessage = "";

  bool get loadMore => _loadMore;

  final _appRepository = AppRepository();

  void loadMoreMovies({bool loadMore = false, List<Results> results}) async {
    /// Start showing the loader
    _loadMore = true;
    notifyListeners();

    /// Wait for response
    NetworkResponse networkingResponse = await _appRepository.getNowPlayingMovies(loadMore: loadMore);

    /// We check the type of response and update the required field
    if (networkingResponse is NetworkingResponseData) {
      /// Updating the APIResponseModel when success
      _nowPlayingResponse = networkingResponse.dataResponse;
      results.addAll(_nowPlayingResponse.results);
      _didFetchNowPlaying = true;
      notifyListeners();
    } else if (networkingResponse is NetworkingException) {
      /// Updating the errorMessage when fails
      nowPlayingNetworkExceptionMessage = networkingResponse.message;
      _didFetchNowPlaying = false;
      notifyListeners();
    }

    /// Stop the loader
    _loadMore = false;
    notifyListeners();
  }
}
