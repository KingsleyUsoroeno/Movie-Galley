import 'package:movies/data/remote/model/Result.dart';

import 'movie_model.dart';

class PopularMoviesDatabaseModel {
  int id;
  int page;
  int totalResults;
  int totalPages;
  List<Results> results;

  PopularMoviesDatabaseModel({this.id, this.page, this.totalResults, this.totalPages, this.results});

  // DATABASE HELPER FUNCTIONS
  factory PopularMoviesDatabaseModel.fromJson(Map<String, dynamic> json) => PopularMoviesDatabaseModel(
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
    return 'PopularMoviesDatabaseModel{id: $id, page: $page, totalResults: $totalResults, totalPages: $totalPages, results: $results}';
  }
}
