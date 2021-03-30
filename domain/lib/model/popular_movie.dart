import 'result.dart';

class PopularMovie {
  int page;
  int totalResults;
  int totalPages;
  List<MovieResult> results;

  PopularMovie({this.page, this.totalResults, this.totalPages, this.results});
}
