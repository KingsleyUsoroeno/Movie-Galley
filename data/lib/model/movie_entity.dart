import 'result_entity.dart';

class MovieEntity {
  int page;
  int totalResults;
  int totalPages;
  List<ResultEntity> results;

  MovieEntity({
    int page,
    int totalResults,
    int totalPages,
    List<ResultEntity> results,
  }) {
    this.page = page;
    this.totalResults = totalResults;
    this.totalPages = totalPages;
    this.results = results;
  }

  MovieEntity.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['totalresults'];
    totalPages = json['totalpages'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results = [];
        results.add(ResultEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['totalresults'] = this.totalResults;
    data['totalpages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Movies{page: $page, totalResults: $totalResults, '
        'totalPages: $totalPages, results: $results}';
  }
}
