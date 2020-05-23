import 'dart:convert';

import '../../../remote/model/Result.dart';

String movieResultToJson(List<Results> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Results> movieResultsFromJson(String str) => List<Results>.from(json.decode(str).map((x) => Results.fromJson(x)));

class MovieDatabaseModel {
  int id;
  int page;
  int totalResults;
  int totalPages;
  List<Results> results;

  MovieDatabaseModel({this.id, this.page, this.totalResults, this.totalPages, this.results});

  // DATABASE HELPER FUNCTIONS
  factory MovieDatabaseModel.fromJson(Map<String, dynamic> json) => MovieDatabaseModel(
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
    return 'MovieModel{id: $id, page: $page, totalResults: $totalResults, totalPages: $totalPages, results: $results}';
  }
}
