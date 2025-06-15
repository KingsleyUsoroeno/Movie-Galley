import 'package:bloc/bloc.dart';
import 'package:domain/domain_dependencies.dart';
import 'package:equatable/equatable.dart';

part 'movie_category_state.dart';

class MovieCategoryCubit extends Cubit<MovieCategoryState> {
  MovieCategoryCubit({required FetchMovieCategoriesUseCase fetchMovieCategoriesUseCase})
    : _fetchMovieCategoriesUseCase = fetchMovieCategoriesUseCase,
      super(MovieCategoryInitialState());

  final FetchMovieCategoriesUseCase _fetchMovieCategoriesUseCase;

  void initialize() async {
    emit(const MovieCategoryLoadingState());
    final result = await _fetchMovieCategoriesUseCase();
    emit(
      result.when(
        success: (movie) => MovieCategorySuccessState(movie.results),
        failure: (exception) => MovieCategoryFailureState(exception.toString()),
      ),
    );
  }

  void refresh() => initialize();
}
