import 'package:bloc/bloc.dart';
import 'package:domain/domain_dependencies.dart';
import 'package:equatable/equatable.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  PopularMoviesCubit({required FetchNowPlayingMovieUseCase fetchNowPlayingMovieUseCase})
    : _fetchNowPlayingMovieUseCase = fetchNowPlayingMovieUseCase,
      super(PopularMoviesInitialState());

  final FetchNowPlayingMovieUseCase _fetchNowPlayingMovieUseCase;

  int _page = 1;

  void initialize() async {
    emit(PopularMoviesLoadingState());
    final result = await _fetchNowPlayingMovieUseCase(_page);
    emit(
      result.when(
        success: (popularMovies) => PopularMoviesSuccessState(popularMovies.results),
        failure: (appException) => PopularMoviesFailureState(appException.toString()),
      ),
    );
    ;
  }
}
