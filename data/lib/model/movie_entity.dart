import 'package:meta/meta.dart';

import 'result_entity.dart';

class MovieEntity {
  final int id;
  final int page;
  final int totalResults;
  final int totalPages;
  final List<ResultEntity> results;

  MovieEntity({
    @required this.id,
    @required this.page,
    @required this.totalResults,
    @required this.totalPages,
    @required this.results,
  });

  MovieEntity copyWith({
    int page,
    int totalResults,
    int totalPages,
    List<ResultEntity> results,
  }) {
    return MovieEntity(
      id: id,
      page: page ?? this.page,
      totalResults: totalResults ?? this.totalResults,
      totalPages: totalPages ?? this.totalPages,
      results: results ?? this.results,
    );
  }

  @override
  String toString() {
    return 'MovieEntity{id: $id, page: $page, totalResults: $totalResults, '
        'totalPages: $totalPages, results: $results}';
  }
}
