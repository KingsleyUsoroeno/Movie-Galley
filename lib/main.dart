import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/bloc/movie/movie_category/bloc.dart';
import 'package:movies/data/bloc/movie/now_playing/bloc.dart';
import 'package:movies/data/bloc/movie/popular_movie/bloc.dart';
import 'package:movies/data/repository/app_repository.dart';
import 'package:movies/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final repository = AppRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => MovieBloc(appRepository: repository)..add(FetchMovies()),
        ),
        BlocProvider<NowPlayingMoviesBloc>(
          create: (_) => NowPlayingMoviesBloc(appRepository: repository)..add(FetchNowPlayingMovies()),
        ),
        BlocProvider<PopularMovieBloc>(
          create: (BuildContext context) => PopularMovieBloc(appRepository: repository)..add(FetchPopularMovies()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Gallery',
        theme: ThemeData(primaryColor: Color(0xFF0A0A0A)),
        home: HomeScreen(),
      ),
    );
  }
}
