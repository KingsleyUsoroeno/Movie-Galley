import 'result.dart';

class Movie {
  int page;
  int totalResults;
  int totalPages;
  List<MovieResult> results;

  Movie({
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

  @override
  String toString() {
    return 'Movies{page: $page, totalResults: $totalResults, '
        'totalPages: $totalPages, results: $results}';
  }
}
