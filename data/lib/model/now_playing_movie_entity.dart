import 'date_entity.dart';
import 'result_entity.dart';

class NowPlayingMovieEntity {
  int id;
  int page;
  int totalResults;
  int totalPages;
  DateEntity dates;
  List<ResultEntity> results;

  NowPlayingMovieEntity({
    this.id,
    this.results,
    this.page,
    this.totalResults,
    this.dates,
    this.totalPages,
  });

  @override
  String toString() {
    return 'NowPlayingMovieEntity{id: $id, page: $page, totalResults: '
        '$totalResults, totalPages: $totalPages, dates: $dates, '
        'results: $results}';
  }
}
