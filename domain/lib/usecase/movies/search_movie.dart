import 'package:dartz/dartz.dart';
import 'package:domain/exception/failure.dart';
import 'package:domain/imports/module_imports.dart';
import 'package:domain/usecase/base/either_use_case.dart';

class SearchMovie extends EitherUseCase<SearchMovieParams, Movie> {
  final MovieRepository movieRepository;

  SearchMovie({this.movieRepository});

  @override
  Future<Either<Failure, Movie>> execute(SearchMovieParams params) async {
    return await movieRepository.searchMovie(
      params.query,
      loadMore: params.loadMore,
    );
  }
}

class SearchMovieParams {
  final String query;
  final bool loadMore;

  SearchMovieParams({this.query, this.loadMore});
}
