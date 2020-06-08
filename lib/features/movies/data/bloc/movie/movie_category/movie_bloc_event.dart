import 'package:equatable/equatable.dart';

abstract class MovieBlocEvent extends Equatable {
  const MovieBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchMovies extends MovieBlocEvent {}

class RefreshMovies extends MovieBlocEvent {}
