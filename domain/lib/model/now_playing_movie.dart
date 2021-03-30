import 'date.dart';
import 'result.dart';

class NowPlayingMovie {
  int page;
  int totalResults;
  int totalPages;
  Date dates;
  List<MovieResult> results;

  NowPlayingMovie({
    this.results,
    this.page,
    this.totalResults,
    this.dates,
    this.totalPages,
  });

  @override
  String toString() {
    return 'NowPlaying{page $page: results: $totalResults, '
        'dates: $dates, totalPages: $totalPages, results: $results}';
  }
}
