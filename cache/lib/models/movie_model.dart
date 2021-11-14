import 'dart:convert';

import 'package:meta/meta.dart';

import 'cache_movie_result.dart';

String movieResultToJson(List<CacheMovieResult> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<CacheMovieResult> movieResultsFromJson(String str) =>
    List<CacheMovieResult>.from(
        json.decode(str).map((x) => CacheMovieResult.fromJson(x)));

class MovieModel {
  final int id;
  final int page;
  final int totalResults;
  final int totalPages;
  final List<CacheMovieResult> results;

  MovieModel({
    @required this.id,
    @required this.totalResults,
    @required this.totalPages,
    @required this.results,
    @required this.page,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "page": page,
        "totalResults": totalResults,
        "totalPages": totalPages,
        "movieResults": movieResultToJson(results),
      };
}
