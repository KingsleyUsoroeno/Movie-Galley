import 'result_entity.dart';

class MovieEntity {
  int page;
  int totalResults;
  int totalPages;
  List<ResultEntity> results;

  MovieEntity({
    int page,
    int totalResults,
    int totalPages,
    List<ResultEntity> results,
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
