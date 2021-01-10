import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../lib/features/movies/data/bloc/movie/movie_category/bloc.dart';
import '../../lib/features/movies/data/repository/movies_repository.dart';

class MockMovieRepository extends Mock implements MovieRepository{}

void main(){
  MovieBloc movieBloc;
  MockMovieRepository userRepository;

  setUp(() {
    userRepository = MockMovieRepository();
    movieBloc = MovieBloc(movieRepository: userRepository);
  });

  tearDown(() {
    movieBloc?.close();
  });

  test('initial state is correct', () {
    expect(movieBloc.initialState, InitialMovieBlocState());
  });



}