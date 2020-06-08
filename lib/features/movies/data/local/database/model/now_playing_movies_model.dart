import 'dart:convert';

import 'package:movies/features/movies/data/remote/model/Result.dart';
import 'package:movies/features/movies/data/remote/model/date.dart';

import 'movie_model.dart';

String datesToJson(Dates dates) => dates != null ? json.encode(dates.toJson()) : json.encode("");

Dates datesFromJson(String str) => Dates.fromJson(json.decode(str));

class NowPlayingMoviesDatabaseModel {
  int id;
  int totalResults;
  int totalPages;
  Dates dates;
  List<Results> results;

  NowPlayingMoviesDatabaseModel({this.id, this.totalResults, this.totalPages, this.dates, this.results});

  // DATABASE HELPER FUNCTIONS
  factory NowPlayingMoviesDatabaseModel.fromJson(Map<String, dynamic> json) => NowPlayingMoviesDatabaseModel(
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
    return 'NowPlayingResponseDatabaseModel{id: $id, totalResults: $totalResults, totalPages: $totalPages, dates: $dates, results: $results}';
  }
}
