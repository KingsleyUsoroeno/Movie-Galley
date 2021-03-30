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
  int page;
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
    this.page,
  });

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "page": page,
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
