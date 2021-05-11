import 'package:flutter_test/flutter_test.dart';
import 'package:movies/core/bloc/movie_category/movie_bloc.dart';

import 'mock__fetch_movie_usecase.dart';

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

  // test('throws AssertionError if MovieRepository is null', () {
  //   expect(
  //     () => MovieBloc(fetchMovie: null),
  //     throwsA(isAssertionError),
  //   );
  // });

  // group('FetchMovies Event', () {
  //   // test(
  //   //     'emits [InitialMovieState, movieLoading, movieError]'
  //   //     ' when FetchMovies is added and fetchAllMovieCategories fails', () {
  //   //   when(fetchMovieUseCase.execute(any))
  //   //       .thenAnswer((_) async => Left(CacheFailure()));
  //   //   // act
  //   //   movieBloc.add(FetchMovies());
  //   //   //assert
  //   //   final expectedResponse = [
  //   //     MovieLoading(),
  //   //     MovieError("Cache Failure"),
  //   //   ];
  //   //
  //   //   expectLater(movieBloc, emitsInOrder(expectedResponse));
  //   // });
  //
  //   // test(
  //   //     'emits [InitialMovieState,movieLoading, MovieLoaded] when FetchMovies is added and fetchAllMovieCategories succeeds',
  //   //     () async {
  //   //   final movies = MockDatabaseModel.movieList;
  //   //
  //   //   when(fetchMovieUseCase.execute(any))
  //   //       .thenAnswer((_) async => Right(movies));
  //   //
  //   //   // act
  //   //   movieBloc.add(FetchMovies());
  //   //
  //   //   // assert
  //   //   final expectedResponse = [
  //   //     MovieLoading(),
  //   //     MovieLoaded(movie: movies.first)
  //   //   ];
  //   //
  //   //   expectLater(
  //   //     movieBloc,
  //   //     emitsInOrder(expectedResponse),
  //   //   );
  //   // });
  // });
}
