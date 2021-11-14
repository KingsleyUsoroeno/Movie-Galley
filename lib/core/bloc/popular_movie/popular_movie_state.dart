import 'package:domain/imports/module_imports.dart';
import 'package:equatable/equatable.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class InitialPopularMovieState extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieLoaded extends PopularMovieState {
  final Movie popularMovie;

  PopularMovieLoaded({this.popularMovie});

  @override
  List<Object> get props => [popularMovie];
}

class PopularMovieError extends PopularMovieState {
  final String errorMessage;

  PopularMovieError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
