import 'package:cache/models/cache_movie_result.dart';

import 'cache_movie_model.dart';

class CachePopularMovie {
  int id;
  int page;
  int totalResults;
  int totalPages;
  List<CacheMovieResult> results;

  CachePopularMovie({
    this.id,
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "page": page,
        "totalResults": totalResults,
        "totalPages": totalPages,
        "movieResults": movieResultToJson(results),
      };

  @override
  String toString() {
    return 'PopularMoviesDatabaseModel{id: $id, page: $page, '
        'totalResults: $totalResults, '
        'totalPages: $totalPages, results: $results}';
  }
}
