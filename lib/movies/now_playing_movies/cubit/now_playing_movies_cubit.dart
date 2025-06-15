import 'package:bloc/bloc.dart';
import 'package:domain/domain_dependencies.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  NowPlayingMoviesCubit({required FetchNowPlayingMovieUseCase fetchNowPlayingMovieUseCase})
    : _fetchNowPlayingMovieUseCase = fetchNowPlayingMovieUseCase,
      super(NowPlayingMoviesInitialState());

  final FetchNowPlayingMovieUseCase _fetchNowPlayingMovieUseCase;
  int _page = 1;

  void initialize() async {
    emit(const NowPlayingMoviesLoadingState());
    final result = await _fetchNowPlayingMovieUseCase(_page);
    emit(
      result.when(
        success: (movie) => NowPlayingMoviesSuccessState(movie.results),
        failure: (exception) => NowPlayingMoviesFailureState(exception.toString()),
      ),
    );
  }

  void fetchMoreMovies() async {
    if (state case NowPlayingMoviesSuccessState(:final movies)) {
      final result = await _fetchNowPlayingMovieUseCase(_page += 1);
      result.when(
        success: (movie) => emit(NowPlayingMoviesSuccessState([...movies, ...movie.results])),
        failure: (exception) {
          _page -= 1;
          emit(NowPlayingMoviesSuccessState(movies));
        },
      );
    }
  }

  void refresh() => initialize();
}
