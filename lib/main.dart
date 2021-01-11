import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/data/bloc/movie/movie_category/movie_bloc.dart';
import 'package:movies/features/movies/data/bloc/movie/now_playing/now_playing_movie_bloc.dart';
import 'package:movies/features/movies/data/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:movies/features/movies/data/bloc/movie/search_result_bloc/bloc.dart';

import 'features/movies/data/bloc/movie/movie_category/movie_event.dart';
import 'features/movies/data/bloc/movie/now_playing/now_playing_movies_event.dart';
import 'features/movies/data/bloc/movie/popular_movie/popular_movie_event.dart';
import 'features/movies/ui/screens/home_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (_) => di.injector<MovieBloc>()..add(FetchMovies()),
        ),
        BlocProvider<NowPlayingMovieBloc>(
          create: (_) => di.injector<NowPlayingMovieBloc>()..add(FetchNowPlayingMovies()),
        ),
        BlocProvider<PopularMovieBloc>(
          create: (BuildContext context) => di.injector<PopularMovieBloc>()..add(FetchPopularMovies()),
        ),
        BlocProvider<MovieSearchBloc>(create: (_) => di.injector<MovieSearchBloc>())
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
