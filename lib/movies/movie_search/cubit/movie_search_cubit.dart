import 'package:bloc/bloc.dart';
import 'package:domain/domain_dependencies.dart';
import 'package:domain/movie/use_case/search_movie_use_case.dart';
import 'package:equatable/equatable.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  MovieSearchCubit({required SearchMovieUseCase searchMovieUseCase})
    : _searchMovieUseCase = searchMovieUseCase,
      super(const MovieSearchInitialState());

  final SearchMovieUseCase _searchMovieUseCase;

  void search(String query) async {
    emit(const MovieSearchLoadingState());
    final result = await _searchMovieUseCase((query: query, page: 1));

    emit(
      result.when(
        success: (results) => MovieSearchSuccessState(results),
        failure: (exception) => MovieSearchFailureState(exception.toString()),
      ),
    );
  }
}
