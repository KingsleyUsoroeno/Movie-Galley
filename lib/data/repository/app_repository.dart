import 'package:movies/data/model/network_response.dart';
import 'package:movies/data/service/network_service.dart';

class AppRepository {
  /// ViewModel calls its Repository to getMovieCategory
  /// The Repository will take care of getting the data from thr right source
  /// Only AppRepository knows that it has to call NetworkRepo()
  /// ViewModel doesn't care if its coming from API or Offline Cache

  final networkService = NetworkService();

  Future<NetworkResponse> getMovieCategory() {
    return networkService.getMovieCategories();
  }

  Future<NetworkResponse> getNowPlayingMovies() {
    return networkService.getNowPlaying();
  }

  Future<NetworkResponse> getPopularMovies() {
    return networkService.getPopularMovies();
  }
}
