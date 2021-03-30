import 'package:dartz/dartz.dart';
import 'package:domain/exception/failure.dart';
import 'package:domain/imports/module_imports.dart';
import 'package:domain/model/now_playing_movie.dart';
import 'package:domain/usecase/base/either_use_case.dart';

class FetchNowPlaying extends EitherUseCase<bool, List<NowPlayingMovie>> {
  final MovieRepository movieRepository;

  FetchNowPlaying({this.movieRepository});

  @override
  Future<Either<Failure, List<NowPlayingMovie>>> execute(bool params) {
    return movieRepository.getAllNowPlayingMovies(loadMore: params);
  }
}
