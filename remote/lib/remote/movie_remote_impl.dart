import 'package:data/contract/remote/movie_remote.dart';
import 'package:data/model/movie_entity.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:remote/helper/remote_constants.dart';
import 'package:remote/helper/safeApiCall.dart';
import 'package:remote/mapper/movie_remote_mapper.dart';
import 'package:remote/models/movie_dto.dart';

class MovieRemoteImpl implements MovieRemote {
  final http.Client httpClient;
  final MovieRemoteMapper movieRemoteMapper;

  MovieRemoteImpl({
    @required this.httpClient,
    @required this.movieRemoteMapper,
  });

  @override
  Future<MovieEntity> fetchMovieCategories() async {
    String url = RemoteConstants.BASE_URL +
        "3/discover/movie?api_key=${RemoteConstants.API_KEY}";
    return await SafeApiCall.makeNetworkRequest(
      () => httpClient.get(Uri.parse(url)),
      successResponse: (data) async {
        final movieResponse = MovieDTO.fromJson(data);
        return movieRemoteMapper.mapFromModel(movieResponse);
      },
    );
  }

  @override
  Future<MovieEntity> fetchNowPlayingMovies({int page = 1}) async {
    print("page is $page");
    final String url = RemoteConstants.BASE_URL +
        "3/movie/now_playing?api_key=${RemoteConstants.API_KEY}"
            "&language=en-US&page=$page";
    return await SafeApiCall.makeNetworkRequest(
        () => httpClient.get(Uri.parse(url)), successResponse: (data) {
      final response = MovieDTO.fromJson(data);
      return movieRemoteMapper.mapFromModel(response);
    });
  }

  @override
  Future<MovieEntity> fetchPopularMovies({int page = 1}) async {
    final String url = RemoteConstants.BASE_URL +
        "3/movie/popular?api_key=${RemoteConstants.API_KEY}"
            "&language=en-US&page=$page";
    return await SafeApiCall.makeNetworkRequest(
      () => httpClient.get(Uri.parse(url)),
      successResponse: (json) {
        final response = MovieDTO.fromJson(json);
        return movieRemoteMapper.mapFromModel(response);
      },
    );
  }

  @override
  Future<MovieEntity> searchForMovie(String query, int page) async {
    final String queryUrl = RemoteConstants.BASE_URL +
        "3/search/movie?api_key=${RemoteConstants.API_KEY}"
            "&language=en-US&query=$query&page="
            "$page&include_adult=true";
    return await SafeApiCall.makeNetworkRequest(
      () => httpClient.get(Uri.parse(queryUrl)),
      successResponse: (data) {
        final movieRemote = MovieDTO.fromJson(data);
        return movieRemoteMapper.mapFromModel(movieRemote);
      },
    );
  }
}
