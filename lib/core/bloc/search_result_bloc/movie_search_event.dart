import 'package:equatable/equatable.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchMovies extends MovieSearchEvent {
  final String movieQuery;

  SearchMovies({this.movieQuery});
}

class FetchMoreMovieForSearchQuery extends MovieSearchEvent {
  final bool loadMore;
  final String movieQuery;

  FetchMoreMovieForSearchQuery({this.loadMore, this.movieQuery});
}
