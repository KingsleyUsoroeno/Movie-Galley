import 'dart:convert';

import 'package:cache/models/cache_movie_result.dart';

String movieResultToJson(List<CacheMovieResult> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<CacheMovieResult> movieResultsFromJson(String str) =>
    List<CacheMovieResult>.from(
        json.decode(str).map((x) => CacheMovieResult.fromJson(x)));

class CacheMovieModel {
  int id;
  int page;
  int totalResults;
  int totalPages;
  List<CacheMovieResult> results;

  CacheMovieModel({
    this.id,
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });

  // DATABASE HELPER FUNCTIONS
  factory CacheMovieModel.fromJson(Map<String, dynamic> json) =>
      CacheMovieModel(
          id: json["id"],
          page: json["page"],
          totalResults: json["totalResults"],
          totalPages: json["totalPages"],
          results: movieResultsFromJson(json["movieResults"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "page": page,
        "totalResults": totalResults,
        "totalPages": totalPages,
        "movieResults": movieResultToJson(results),
      };

  @override
  String toString() {
    return 'CacheMovieModel{id: $id, page: $page, totalResults: $totalResults, '
        'totalPages: $totalPages, results: $results}';
  }
}
