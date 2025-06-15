import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/movie_categories/cubit/movie_category_cubit.dart';
import 'package:movies/movies/movie_search/cubit/movie_search_cubit.dart';
import 'package:movies/movies/now_playing_movies/cubit/now_playing_movies_cubit.dart';
import 'package:movies/movies/popular_movies/cubit/popular_movies_cubit.dart';
import 'di/injection_container.dart' as di;
import 'home/home_screen.dart';

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
        BlocProvider<MovieCategoryCubit>(create: (_) => di.injector<MovieCategoryCubit>()..initialize()),
        BlocProvider<NowPlayingMoviesCubit>(create: (_) => di.injector<NowPlayingMoviesCubit>()..initialize()),
        BlocProvider<PopularMoviesCubit>(create: (_) => di.injector<PopularMoviesCubit>()..initialize()),
        BlocProvider<MovieSearchCubit>(create: (_) => di.injector<MovieSearchCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Gallery',
        theme: ThemeData(primaryColor: Color(0xFF0A0A0A), appBarTheme: AppBarTheme(backgroundColor: Colors.black)),
        home: HomeScreen(),
      ),
    );
  }
}
