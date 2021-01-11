import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/core/error/failures.dart';
import 'package:movies/features/movies/data/bloc/movie/now_playing/bloc.dart';
import 'package:movies/features/movies/data/repository/movies_repository.dart';

import 'mock__movie_repository.dart';
import 'mock_database_model.dart';

void main() {
  MovieRepository movieRepository;
  NowPlayingMovieBloc nowPlayingMovieBloc;

  //setUp will get run before each test in the group to ensure that every test starts off in the exact same state.
  setUp(() {
    movieRepository = MockMovieRepository();
    nowPlayingMovieBloc = NowPlayingMovieBloc(movieRepository: movieRepository);
  });

  tearDown(() {
    nowPlayingMovieBloc?.close();
  });

  test('throws AssertionError if WeatherRepository is null', () {
    expect(
      () => NowPlayingMovieBloc(movieRepository: null),
      throwsA(isAssertionError),
    );
  });

  test('initial state is correct', () {
    expect(InitialNowPlayingMoviesState(), nowPlayingMovieBloc.initialState);
  });

  group("FetchNowPlayingMovies", () {
    test('emits [InitialNowPlayingMoviesState,NowPlayingMovieLoading, NowPlayingMovieLoaded] when FetchMovies is added and fetchAllNowPlayingMovies succeeds',
        () async {
      final movie = MockDatabaseModel.nowPlayingMovies;

      when(movieRepository.fetchAllNowPlayingMovies(loadMore: false)).thenAnswer((_) async => Right(movie));

      // act
      nowPlayingMovieBloc.add(FetchNowPlayingMovies());

      // assert
      final expectedResponse = [InitialNowPlayingMoviesState(), NowPlayingMovieLoading(), NowPlayingMovieLoaded(nowPlayingMovies: movie)];

      expectLater(
        nowPlayingMovieBloc,
        emitsInOrder(expectedResponse),
      );
    });

    test(
        'emits [InitialNowPlayingMoviesState, NowPlayingMovieLoading, NowPlayingMovieError] when FetchNowPlayingMovies is added and fetchAllNowPlayingMovies fails',
        () {
      when(movieRepository.fetchAllNowPlayingMovies()).thenAnswer((_) async => Left(CacheFailure()));

      // act
      nowPlayingMovieBloc.add(FetchNowPlayingMovies());

      //assert
      final expectedResponse = [InitialNowPlayingMoviesState(), NowPlayingMovieLoading(), NowPlayingMovieError(errorMessage: "Cache Failure")];

      expectLater(nowPlayingMovieBloc, emitsInOrder(expectedResponse));
    });
  });

  group("FetchMoreMovies", () {});

  group("RefreshNowPlayingMovies", () {});
}
