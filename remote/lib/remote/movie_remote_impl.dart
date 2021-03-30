import 'package:data/contract/remote/movie_remote.dart';
import 'package:data/model/movie_entity.dart';
import 'package:data/model/now_playing_movie_entity.dart';
import 'package:data/model/popular_movie_entity.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:remote/helper/remote_constants.dart';
import 'package:remote/helper/safeApiCall.dart';
import 'package:remote/mapper/movie_remote_mapper.dart';
import 'package:remote/mapper/now_playing_movie_remote_mapper.dart';
import 'package:remote/mapper/popular_movie_model_mapper.dart';
import 'package:remote/models/response/movie_response.dart';
import 'package:remote/models/response/now_playing_movie_response.dart';
import 'package:remote/models/response/popular_movie_response.dart';

class MovieRemoteImpl implements MovieRemote {
  final http.Client httpClient;
  final MovieRemoteMapper movieRemoteMapper;
  final NowPlayingMovieRemoteMapper nowPlayingMovieMapper;
  final PopularMovieModelMapper popularMovieEntityMapper;

  MovieRemoteImpl({
    @required this.httpClient,
    @required this.movieRemoteMapper,
    @required this.nowPlayingMovieMapper,
    @required this.popularMovieEntityMapper,
  });

  @override
  Future<MovieEntity> fetchAllMovieCategories() async {
    String url = RemoteConstants.BASE_URL +
        "3/discover/movie?api_key=${RemoteConstants.API_KEY}";
    return await SafeApiCall.makeNetworkRequest(
      () => httpClient.get(Uri.parse(url)),
      successResponse: (data) async {
        final movieRemote = MovieResponse.fromJson(data);
        return movieRemoteMapper.mapFromModel(movieRemote);
      },
    );
  }

  @override
  Future<NowPlayingMovieEntity> fetchAllNowPlayingMovies({
    int page = 1,
    bool loadMore = false,
  }) async {
    final String url = RemoteConstants.BASE_URL +
        "3/movie/now_playing?api_key=${RemoteConstants.API_KEY}"
            "&language=en-US&page=$page";
    return await SafeApiCall.makeNetworkRequest(
        () => httpClient.get(Uri.parse(url)), successResponse: (data) {
      final response = NowPlayingMovieResponse.fromJson(data);
      return nowPlayingMovieMapper.mapFromModel(response);
    });
  }

  @override
  Future<PopularMovieEntity> fetchPopularMovies({
    int page = 1,
    bool loadMore = false,
  }) async {
    final String url = RemoteConstants.BASE_URL +
        "3/movie/popular?api_key=${RemoteConstants.API_KEY}"
            "&language=en-US&page=$page";
    return await SafeApiCall.makeNetworkRequest(
      () => httpClient.get(Uri.parse(url)),
      successResponse: (json) {
        final response = PopularMovieResponse.fromJson(json);
        return popularMovieEntityMapper.mapFromModel(response);
      },
    );
  }

  @override
  Future<MovieEntity> searchForMovie(
    String query,
    int page, {
    bool loadMore = false,
  }) async {
    final String queryUrl = RemoteConstants.BASE_URL +
        "3/search/movie?api_key=${RemoteConstants.API_KEY}"
            "&language=en-US&query=$query&page="
            "$page&include_adult=true";
    return await SafeApiCall.makeNetworkRequest(
      () => httpClient.get(Uri.parse(queryUrl)),
      successResponse: (data) {
        final movieRemote = MovieResponse.fromJson(data);
        return movieRemoteMapper.mapFromModel(movieRemote);
      },
    );
  }
}
