import 'dart:convert';

import 'package:cache/models/cache_date_model.dart';
import 'package:cache/models/cache_movie_result.dart';

import 'cache_movie_model.dart';

String datesToJson(CacheDateModel dates) =>
    dates != null ? json.encode(dates.toJson()) : json.encode("");

CacheDateModel datesFromJson(String str) =>
    CacheDateModel.fromJson(json.decode(str));

class CacheNowPlayingMovie {
  int id;
  int totalResults;
  int totalPages;
  CacheDateModel dates;
  List<CacheMovieResult> results;

  CacheNowPlayingMovie({
    this.id,
    this.totalResults,
    this.totalPages,
    this.dates,
    this.results,
  });

  // DATABASE HELPER FUNCTIONS
  factory CacheNowPlayingMovie.fromJson(Map<String, dynamic> json) =>
      CacheNowPlayingMovie(
          id: json["id"],
          totalResults: json["totalResults"],
          totalPages: json["totalPages"],
          dates: datesFromJson(json["dates"]),
          results: movieResultsFromJson(json["movieResults"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalResults": totalResults,
        "totalPages": totalPages,
        "dates": datesToJson(dates),
        "movieResults": movieResultToJson(results),
      };

  @override
  String toString() {
    return 'CacheNowPlayingMovies{id: $id, totalResults: $totalResults, '
        'totalPages: $totalPages, dates: $dates, results: $results}';
  }
}
