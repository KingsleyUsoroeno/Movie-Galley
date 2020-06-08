import 'package:movies/features/movies/data/local/database/model/now_playing_movies_model.dart';
import 'package:movies/features/movies/data/remote/model/date.dart';

import 'Result.dart';

class NowPlayingResponse {
  int page;
  int totalResults;
  int totalPages;
  Dates dates;
  List<Results> results;

  NowPlayingResponse({this.results, this.page, this.totalResults, this.dates, this.totalPages});

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

  NowPlayingMoviesDatabaseModel toDatabaseModel() =>
      NowPlayingMoviesDatabaseModel(totalResults: totalResults, totalPages: totalPages, dates: dates, results: results);

  @override
  String toString() {
    return 'NowPlaying{page $page: results: $totalResults, dates: $dates, totalPages: $totalPages, results: $results}';
  }
}
