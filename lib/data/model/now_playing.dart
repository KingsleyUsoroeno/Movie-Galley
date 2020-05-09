import 'package:movies/data/model/date.dart';

import 'Result.dart';

class NowPlayingResponse {
  List<Results> results;
  int page;
  int totalResults;
  Dates dates;
  int totalPages;

  NowPlayingResponse(
      {this.results,
      this.page,
      this.totalResults,
      this.dates,
      this.totalPages});

  NowPlayingResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
    page = json['page'];
    totalResults = json['total_results'];
    dates = json['dates'] != null ? new Dates.fromJson(json['dates']) : null;
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
    return 'NowPlaying{results: $results, page: $page, totalResults: $totalResults, dates: $dates, totalPages: $totalPages}';
  }
}
