import 'result_entity.dart';

class MovieEntity {
  int id;
  int page;
  int totalResults;
  int totalPages;
  List<ResultEntity> results;

  MovieEntity({
    this.id,
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });

  @override
  String toString() {
    return 'Movies{page: $page, totalResults: $totalResults, '
        'totalPages: $totalPages, results: $results}';
  }
}
