import 'package:equatable/equatable.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayingMovies extends NowPlayingMoviesEvent {}

class FetchMoreMovies extends NowPlayingMoviesEvent {
  final bool loadMore;

  FetchMoreMovies({this.loadMore});
}
