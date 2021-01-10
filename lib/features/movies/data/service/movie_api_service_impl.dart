import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movies/core/constant.dart';
import 'package:movies/core/error/exceptions.dart';
import 'package:movies/features/movies/data/remote/model/movies.dart';
import 'package:movies/features/movies/data/remote/model/now_playing.dart';
import 'package:movies/features/movies/data/remote/model/popular_movie.dart';

import 'movie_api_service.dart';

class MovieApiServiceImpl extends MovieApiService {
  int _perNowPlayingPage = 1;
  int _perPopularMoviePage = 1;
  int _loadMoreSearchResult = 1;

  final http.Client client;

  MovieApiServiceImpl({@required this.client});

  @override
  Future<Movies> getMovieCategories() async {
    ///**/ URL Called "http://api.themoviedb.org/3/discover/movie?api_key=98d4ab8983c3a5727df9ab4f565f5f4a";

    final response = await client.get(Constants.BASE_URL + "3/discover/movie?api_key=${Constants.API_KEY}");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON and log it to the console.
      final parsedJson = await jsonDecode(response.body);
      debugPrint("movie category response is $parsedJson");
      return Movies.fromJson(parsedJson);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load movies');
    }

    // try {
    //   final response = await client.get(url);
    //   if (response.statusCode == 200) {
    //     // If server returns an OK response, parse the JSON
    //     print("movie category from server is $parsedJson");
    //     return Movies.fromJson(parsedJson);
    //   } else {
    //     throw ServerException();
    //   }
    // } catch (e) {
    //   if (e is SocketException) {
    //     throw InternetException();
    //   }
    //   throw ServerException();
    // }
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

      final response = await client.get(url);
      if (response.statusCode == 200) {
        final parsedJson = await jsonDecode(response.body);
        print("Now playing results is  $parsedJson");
        // If server returns an OK response, parse the JSON
        return NowPlayingResponse.fromJson(parsedJson);
      } else {
        print("Caught an exception here due to ${response.statusCode} and ${response.body}");
        return null;
      }
    } catch (e) {
      print("exception is ${e.toString()}");
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

      final response = await client.get(url);
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

  @override
  Future<Movies> searchForMovie(String query, {bool loadMore = false}) async {
    /*API Request goes to these route
    * https://api.themoviedb.org/3/search/movie?api_key=98d4ab8983c3a5727df9ab4f565f5f4a&language=en-US&query=fifty%20shades%20of%20grey&page=1&include_adult=true */
    print("Search for movie called");
    if (loadMore == true) {
      _loadMoreSearchResult += 1;
      print("perPage value is $_loadMoreSearchResult");
    }

    try {
      final String queryUrl =
          Constants.BASE_URL + "3/search/movie?api_key=${Constants.API_KEY}&language=en-US&query=$query&page=$_loadMoreSearchResult&include_adult=true";

      final response = await client.get(queryUrl);
      if (response.statusCode == 200) {
        final parsedJson = await jsonDecode(response.body);
        // If server returns an OK response, parse the JSON
        print("movie query result is $parsedJson");
        return Movies.fromJson(parsedJson);
      } else {
        return null;
      }
    } catch (e) {
      if (e is SocketException) {
        throw InternetException();
      }
      throw ServerException();
    }
  }

  Future<Movies> getMovieCategoriesTest(http.Client client) async {
    ///**/ URL Called "http://api.themoviedb.org/3/discover/movie?api_key=98d4ab8983c3a5727df9ab4f565f5f4a";

    final response = await client.get(Constants.BASE_URL + "3/discover/movie?api_key=${Constants.API_KEY}");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON and log it to the console.
      final parsedJson = await jsonDecode(response.body);
      debugPrint("movie category response is $parsedJson");
      return Movies.fromJson(parsedJson);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load movies');
    }

    // try {
    //   final response = await client.get(url);
    //   if (response.statusCode == 200) {
    //     // If server returns an OK response, parse the JSON
    //     print("movie category from server is $parsedJson");
    //     return Movies.fromJson(parsedJson);
    //   } else {
    //     throw ServerException();
    //   }
    // } catch (e) {
    //   if (e is SocketException) {
    //     throw InternetException();
    //   }
    //   throw ServerException();
    // }
  }
}
