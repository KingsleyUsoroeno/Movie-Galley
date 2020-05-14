import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movies/data/model/movies.dart';
import 'package:movies/data/model/network_response.dart';
import 'package:movies/data/model/now_playing.dart';
import 'package:movies/data/model/popular_movie.dart';

import '../model/network_response.dart';

// Todo try and build a function that encapsulates the try/Catch stuff
class NetworkService {
  final String _apiKey = "98d4ab8983c3a5727df9ab4f565f5f4a";
  final String _baseUrl = "https://api.themoviedb.org/";
  int _perNowPlayingPage = 1;
  int _perPopularMoviePage = 1;

  Future<NetworkResponse> getMovieCategories() async {
    print("getMovieCategories() Called");
    //"http://api.themoviedb.org/3/discover/movie?api_key=98d4ab8983c3a5727df9ab4f565f5f4a";
    try {
      final String url = "http://api.themoviedb.org/3/discover/movie?api_key=$_apiKey";
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final parsedJson = await jsonDecode(response.body);
        // If server returns an OK response, parse the JSON
        //print("getMovieCategories $parsedJson");
        final movieResponse = Movies.fromJson(parsedJson);
        //print(movieResponse.results);
        return NetworkingResponseData<Movies>(movieResponse);
      } else {
        return NetworkingException("Failed to fetch your movie Categories ${response.statusCode}");
      }
    } catch (e) {
      if (e is SocketException) {
        return NetworkingException("Internet Connection is not Available");
      }
      return NetworkingException(e.toString());
    }
  }

  Future<NetworkResponse> getNowPlaying({bool loadMore = false}) async {
    // https://api.themoviedb.org/3/movie/now_playing?api_key=98d4ab8983c3a5727df9ab4f565f5f4a&language=en-US&page=1
    if (loadMore == true) {
      _perNowPlayingPage += 1;
      print("perPage value is $_perNowPlayingPage");
    }

    print("loading per page is $_perNowPlayingPage");
    try {
      final String url = "https://api.themoviedb.org/3/movie/now_playing?api_key=$_apiKey&language=en-US&page=$_perNowPlayingPage";

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final parsedJson = await jsonDecode(response.body);
        print("Now playing results is  $parsedJson");
        // If server returns an OK response, parse the JSON
        final nowPlaying = NowPlayingResponse.fromJson(parsedJson);
        return NetworkingResponseData<NowPlayingResponse>(nowPlaying);
      } else {
        return NetworkingException("Failed to fetch your now showing categories ${response.statusCode}");
      }
    } catch (e) {
      if (e is SocketException) {
        return NetworkingException("Internet Connection is not Available");
      }
      return NetworkingException(e.toString());
    }
  }

  Future<NetworkResponse> getPopularMovies({bool loadMore = false}) async {
    //https://api.themoviedb.org/3/movie/popular?api_key=98d4ab8983c3a5727df9ab4f565f5f4a&language=en-US&page=1
    if (loadMore == true) {
      _perPopularMoviePage += 1;
      print("perPage value is $_perPopularMoviePage");
    }

    try {
      final String url = "https://api.themoviedb.org/3/movie/popular?api_key=$_apiKey&language=en-US&page=$_perPopularMoviePage";

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final parsedJson = await jsonDecode(response.body);
        // If server returns an OK response, parse the JSON
        print("getPopularMovies $parsedJson");
        final popularMovies = PopularMovie.fromJson(parsedJson);
        print(popularMovies.results);
        return NetworkingResponseData<PopularMovie>(popularMovies);
      } else {
        return NetworkingException("Failed to fetch your now showing categories ${response.statusCode}");
      }
    } catch (e) {
      if (e is SocketException) {
        return NetworkingException("Internet Connection is not Available");
      }
      return NetworkingException(e.toString());
    }
  }
}
