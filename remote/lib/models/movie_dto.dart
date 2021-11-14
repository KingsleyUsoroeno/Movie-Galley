import 'package:meta/meta.dart';

import 'movie_result.dart';

class MovieDTO {
  final int page;
  final List<MovieResult> movieResults;
  final int totalPages;
  final int totalResults;

  MovieDTO({
    @required this.page,
    @required this.movieResults,
    @required this.totalPages,
    @required this.totalResults,
  });

  factory MovieDTO.fromJson(Map<String, dynamic> json) {
    return MovieDTO(
      page: json['page'],
      movieResults: json['results'] == null
          ? []
          : List.from(json['results'])
              .map((e) => MovieResult.fromJson(e))
              .toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}
