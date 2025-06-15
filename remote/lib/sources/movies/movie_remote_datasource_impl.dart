import 'dart:convert';

import 'package:data/sources/movie/movie_remote_datasource.dart';
import 'package:domain/movie/entity/movie_entity.dart';
import 'package:domain/movie/entity/movie_info_entity.dart';
import 'package:http/http.dart' as http;
import 'package:remote/constants/remote_constants.dart';
import 'package:remote/sources/movies/movie_info.dart';

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final http.Client httpClient;

  MovieRemoteDatasourceImpl({required this.httpClient});

  @override
  Future<MovieCategoryEntity> fetchMovieCategories() async {
    final String url = "${RemoteConstants.BASE_URL}3/discover/movie?api_key=${RemoteConstants.API_KEY}";
    return MovieCategoryEntity(results: await httpClient.fetchMovie(url));
  }

  @override
  Future<NowPlayingMovieEntity> fetchNowPlayingMovies({int page = 1}) async {
    final String url =
        RemoteConstants.BASE_URL +
        "3/movie/now_playing?api_key=${RemoteConstants.API_KEY}"
            "&language=en-US&page=$page";
    return NowPlayingMovieEntity(results: await httpClient.fetchMovie(url));
  }

  @override
  Future<PopularMovieEntity> fetchPopularMovies({int page = 1}) async {
    final String url =
        RemoteConstants.BASE_URL +
        "3/movie/popular?api_key=${RemoteConstants.API_KEY}"
            "&language=en-US&page=$page";
    return PopularMovieEntity(results: await httpClient.fetchMovie(url));
  }

  @override
  Future<List<MovieInfoEntity>> searchForMovie(String query, int page) async {
    final String url =
        RemoteConstants.BASE_URL +
        "3/search/movie?api_key=${RemoteConstants.API_KEY}"
            "&language=en-US&query=$query&page="
            "$page&include_adult=true";
    return httpClient.fetchMovie(url);
  }
}

extension on http.Client {
  Future<List<MovieInfoEntity>> fetchMovie(String url) async {
    final response = await get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return List.from(body['results']).map((e) => MovieInfo.fromJson(e)).movies;
  }
}

extension on Iterable<MovieInfo> {
  List<MovieInfoEntity> get movies {
    return this.map((e) {
      return MovieInfoEntity(
        e.backdropPath,
        e.originalLanguage,
        e.originalTitle,
        e.genreIds,
        e.title,
        e.overview,
        e.releaseDate,
        e.video,
        e.posterPath,
        e.popularity,
        e.voteCount,
        e.id,
        e.adult,
      );
    }).toList();
  }
}
