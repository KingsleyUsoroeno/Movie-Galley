import 'package:movies/data/model/database/model/popular_movie_model.dart';

import 'Result.dart';

class PopularMovie {
  int page;
  int totalResults;
  int totalPages;
  List<Results> results;

  PopularMovie({this.page, this.totalResults, this.totalPages, this.results});

  PopularMovie.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }

  PopularMoviesDatabaseModel toDatabaseModel() =>
      PopularMoviesDatabaseModel(page: page, totalResults: totalResults, totalPages: totalPages, results: results);

  @override
  String toString() {
    return 'PopularMovie{page: $page, totalResults: $totalResults, totalPages: $totalPages, results: $results}';
  }
}
