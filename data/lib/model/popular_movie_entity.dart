import 'result_entity.dart';

class PopularMovieEntity {
  int page;
  int totalResults;
  int totalPages;
  List<ResultEntity> results;

  PopularMovieEntity({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });
}
