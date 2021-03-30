import 'movie_result.dart';

class MovieResponse {
  int page;
  int totalResults;
  int totalPages;
  List<MovieResult> results;

  MovieResponse({
    int page,
    int totalResults,
    int totalPages,
    List<MovieResult> results,
  }) {
    this.page = page;
    this.totalResults = totalResults;
    this.totalPages = totalPages;
    this.results = results;
  }

  MovieResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(new MovieResult.fromJson(v));
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

  @override
  String toString() {
    return 'Movies{page: $page, totalResults: $totalResults, '
        'totalPages: $totalPages, results: $results}';
  }
}
