import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/exception/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/core/bloc/movie_category/movie_bloc.dart';
import 'package:movies/core/bloc/movie_category/movie_event.dart';
import 'package:movies/core/bloc/movie_category/movie_state.dart';

import 'mock__fetch_movie_usecase.dart';
import 'mock_database_model.dart';

void main() {
  MockFetchMovieUseCase fetchMovieUseCase;
  MovieBloc movieBloc;

  //setUp will get run before each test in the group to ensure that every test starts off in the exact same state.
  setUp(() {
    fetchMovieUseCase = MockFetchMovieUseCase();
    movieBloc = MovieBloc(fetchMovie: fetchMovieUseCase);
  });

  tearDown(() {
    movieBloc?.close();
  });

  test('throws AssertionError if MovieRepository is null', () {
    expect(
      () => MovieBloc(fetchMovie: null),
      throwsA(isAssertionError),
    );
  });

  group('FetchMovies Event', () {
    blocTest(
      'emits [MovieLoading, MovieError] when FetchMovies'
      ' is added and movies are not retrieved successfully',
      build: () {
        when(fetchMovieUseCase.execute(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        return movieBloc;
      },
      act: (MovieBloc bloc) {
        bloc.add(FetchMovies());
      },
      expect: () => [MovieLoading(), MovieError("Cache Failure")],
    );

    blocTest(
      'emits [MovieLoading, MovieLoaded] when FetchMovies'
      ' is added and movies are retrieved successfully',
      build: () {
        final movies = MockDatabaseModel.movieList;
        when(fetchMovieUseCase.execute(any))
            .thenAnswer((_) async => Right(movies));
        return movieBloc;
      },
      act: (MovieBloc bloc) {
        bloc.add(FetchMovies());
      },
      expect: () =>
          [MovieLoading(), MovieLoaded(movie: MockDatabaseModel.movie)],
    );
  });
}
