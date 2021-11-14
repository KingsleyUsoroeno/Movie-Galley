import 'package:flutter/material.dart';

import 'movie_result.dart';

class Movie {
  final int id;
  final int page;
  final int totalResults;
  final int totalPages;
  final List<MovieResult> results;

  Movie({
    @required this.id,
    @required this.totalPages,
    @required this.page,
    @required this.results,
    @required this.totalResults,
  });
}
