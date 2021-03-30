import 'result_entity.dart';

class PopularMovieEntity {
  int id;
  int page;
  int totalResults;
  int totalPages;
  List<ResultEntity> results;

  PopularMovieEntity({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
    this.id,
  });

  @override
  String toString() {
    return 'PopularMovieEntity{id: $id, page: $page, totalResults: '
        '$totalResults, totalPages: $totalPages, results: $results}';
  }
}
