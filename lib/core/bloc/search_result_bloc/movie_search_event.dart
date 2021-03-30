import 'package:equatable/equatable.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchMovies extends MovieSearchEvent {
  final String movieQuery;
  final int page;

  SearchMovies({this.page, this.movieQuery});
}

class FetchMoreMovieForSearchQuery extends MovieSearchEvent {
  final bool loadMore;
  final String movieQuery;

  FetchMoreMovieForSearchQuery({this.loadMore, this.movieQuery});
}
