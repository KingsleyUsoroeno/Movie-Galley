import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends MovieEvent {}

class FetchMovies extends MovieEvent {}

class FetchNowPlayingMovies extends MovieEvent {}

class FetchPopularMovies extends MovieEvent {}
