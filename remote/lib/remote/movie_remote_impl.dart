import 'package:data/contract/remote/movie_remote.dart';
import 'package:data/model/movie_entity.dart';
import 'package:data/model/now_playing_movie_entity.dart';
import 'package:data/model/popular_movie_entity.dart';
import 'package:http/http.dart' as http;
import 'package:remote/helper/remote_constants.dart';
import 'package:remote/helper/safeApiCall.dart';
import 'package:remote/mapper/movie_remote_mapper.dart';
import 'package:remote/models/response/movie_remote_model.dart';

class MovieRemoteImpl implements MovieRemote {
  final http.Client httpClient;
  final MovieRemoteMapper movieRemoteMapper;

  int _perNowPlayingPage = 1;
  int _perPopularMoviePage = 1;
  int _loadMoreSearchResult = 1;

  int get perNowPlayingPage => _perNowPlayingPage;

  int get perPopularMoviePage => _perPopularMoviePage;

  int get loadMoreSearchResult => _loadMoreSearchResult;

  MovieRemoteImpl({
    this.httpClient,
    this.movieRemoteMapper,
  });

  @override
  Future<MovieEntity> fetchAllMovieCategories() async {
    String url = RemoteConstants.BASE_URL +
        "3/discover/movie?api_key=${RemoteConstants.API_KEY}";
    return await SafeApiCall.makeNetworkRequest(
      () => httpClient.get(Uri.parse(url)),
      successResponse: (data) async {
        final movieRemote = MovieRemoteModel.fromJson(data);
        return movieRemoteMapper.mapFromModel(movieRemote);
      },
    );
  }

  @override
  Future<NowPlayingMovieEntity> fetchAllNowPlayingMovies(
      {bool loadMore = false}) {
    final String url = RemoteConstants.BASE_URL +
        "3/movie/now_playing?api_key=${RemoteConstants.API_KEY}"
            "&language=en-US&page=$_perNowPlayingPage";
    if (loadMore) {
      _perNowPlayingPage += 1;
    }

    return SafeApiCall.makeNetworkRequest(
      () => httpClient.get(Uri.parse(url)),
      successResponse: (data) {},
    );
  }

  @override
  Future<PopularMovieEntity> fetchPopularMovies({bool loadMore = false}) {
    final String url = RemoteConstants.BASE_URL +
        "3/movie/popular?api_key=${RemoteConstants.API_KEY}"
            "&language=en-US&page=$_perPopularMoviePage";
    if (loadMore) {
      _perPopularMoviePage += 1;
    }

    return SafeApiCall.makeNetworkRequest(
      () => httpClient.get(Uri.parse(url)),
      successResponse: (data) {},
    );
  }

  @override
  Future<MovieEntity> searchForMovie(String query,
      {bool loadMore = false}) async {
    final String queryUrl = RemoteConstants.BASE_URL +
        "3/search/movie?api_key=${RemoteConstants.API_KEY}"
            "&language=en-US&query=$query&page="
            "$_loadMoreSearchResult&include_adult=true";

    return await SafeApiCall.makeNetworkRequest(
      () => httpClient.get(Uri.parse(queryUrl)),
      successResponse: (data) {
        final movieRemote = MovieRemoteModel.fromJson(data);
        return movieRemoteMapper.mapFromModel(movieRemote);
      },
    );
  }
}
