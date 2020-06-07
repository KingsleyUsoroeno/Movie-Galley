import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as httpClient;
import 'package:movies/core/constant.dart';
import 'package:movies/core/error/exceptions.dart';
import 'package:movies/features/movies/data/remote/model/movies.dart';
import 'package:movies/features/movies/data/remote/model/now_playing.dart';
import 'package:movies/features/movies/data/remote/model/popular_movie.dart';

abstract class MovieApiService {
  Future<Movies> getMovieCategories();

  Future<NowPlayingResponse> getNowPlayingMovies({bool loadMore = false});

  Future<PopularMovie> getPopularMovies({bool loadMore = false});
}

class MovieApiServiceImpl extends MovieApiService {
  int _perNowPlayingPage = 1;
  int _perPopularMoviePage = 1;

  @override
  Future<Movies> getMovieCategories() async {
    print("getMovieCategories() Called");

    ///**/"http://api.themoviedb.org/3/discover/movie?api_key=98d4ab8983c3a5727df9ab4f565f5f4a";
    try {
      final String url = Constants.BASE_URL + "3/discover/movie?api_key=${Constants.API_KEY}";
      final response = await httpClient.get(url);
      if (response.statusCode == 200) {
        final parsedJson = await jsonDecode(response.body);
        // If server returns an OK response, parse the JSON
        print("movie category from server is $parsedJson");
        return Movies.fromJson(parsedJson);
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is SocketException) {
        throw InternetException();
      }
      throw ServerException();
    }
  }

  @override
  Future<NowPlayingResponse> getNowPlayingMovies({bool loadMore = false}) async {
    ///* https://api.themoviedb.org/3/movie/now_playing?api_key=98d4ab8983c3a5727df9ab4f565f5f4a&language=en-US&page=1
    if (loadMore == true) {
      _perNowPlayingPage += 1;
      print("perPage value is $_perNowPlayingPage");
    }

    print("loading per page is $_perNowPlayingPage");
    try {
      final String url = Constants.BASE_URL + "3/movie/now_playing?api_key=${Constants.API_KEY}&language=en-US&page=$_perNowPlayingPage";

      final response = await httpClient.get(url);
      if (response.statusCode == 200) {
        final parsedJson = await jsonDecode(response.body);
        print("Now playing results is  $parsedJson");
        // If server returns an OK response, parse the JSON
        return NowPlayingResponse.fromJson(parsedJson);
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is SocketException) {
        throw InternetException();
      }
      throw ServerException();
    }
  }

  @override
  Future<PopularMovie> getPopularMovies({bool loadMore = false}) async {
    //https://api.themoviedb.org/3/movie/popular?api_key=98d4ab8983c3a5727df9ab4f565f5f4a&language=en-US&page=1
    if (loadMore == true) {
      _perPopularMoviePage += 1;
      print("perPage value is $_perPopularMoviePage");
    }

    try {
      final String url = Constants.BASE_URL + "3/movie/popular?api_key=${Constants.API_KEY}&language=en-US&page=$_perPopularMoviePage";

      final response = await httpClient.get(url);
      if (response.statusCode == 200) {
        final parsedJson = await jsonDecode(response.body);
        // If server returns an OK response, parse the JSON
        print("getPopularMovies $parsedJson");
        return PopularMovie.fromJson(parsedJson);
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is SocketException) {
        throw InternetException();
      }
      throw ServerException();
    }
  }
}
