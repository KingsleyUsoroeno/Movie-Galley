import 'dart:convert';

import 'package:movies/data/remote/model/Result.dart';
import 'package:movies/data/remote/model/date.dart';

import 'movie_model.dart';

String datesToJson(Dates dates) => json.encode(dates.toJson());

Dates datesFromJson(String str) => Dates.fromJson(json.decode(str));

class NowPlayingDatabaseModel {
  int id;
  int totalResults;
  int totalPages;
  Dates dates;
  List<Results> results;

  NowPlayingDatabaseModel({this.id, this.totalResults, this.totalPages, this.dates, this.results});

  // DATABASE HELPER FUNCTIONS
  factory NowPlayingDatabaseModel.fromJson(Map<String, dynamic> json) => NowPlayingDatabaseModel(
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
