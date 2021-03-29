import 'date_entity.dart';
import 'result_entity.dart';

class NowPlayingMovieEntity {
  int page;
  int totalResults;
  int totalPages;
  DateEntity dates;
  List<ResultEntity> results;

  NowPlayingMovieEntity(
      {this.results,
      this.page,
      this.totalResults,
      this.dates,
      this.totalPages});

  NowPlayingMovieEntity.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(ResultEntity.fromJson(v));
      });
    }
    page = json['page'];
    totalResults = json['total_results'];
    dates =
        json['dates'] != null ? new DateEntity.fromJson(json['dates']) : null;
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    if (this.dates != null) {
      data['dates'] = this.dates.toJson();
    }
    data['total_pages'] = this.totalPages;
    return data;
  }

  @override
  String toString() {
    return 'NowPlaying{page $page: results: $totalResults, '
        'dates: $dates, totalPages: $totalPages, results: $results}';
  }
}
