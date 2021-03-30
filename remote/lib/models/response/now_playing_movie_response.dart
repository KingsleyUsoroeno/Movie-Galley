import 'package:remote/models/response/date_response.dart';
import 'package:remote/models/response/movie_result.dart';

class NowPlayingMovieResponse {
  DateResponse dates;
  int page;
  List<MovieResult> results;
  int totalPages;
  int totalResults;

  NowPlayingMovieResponse({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  NowPlayingMovieResponse.fromJson(Map<String, dynamic> json) {
    dates =
        json['dates'] != null ? new DateResponse.fromJson(json['dates']) : null;
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(MovieResult.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dates != null) {
      data['dates'] = this.dates.toJson();
    }
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}
