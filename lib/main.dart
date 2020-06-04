import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/bloc/movie_event.dart';
import 'package:movies/data/bloc/movies_bloc.dart';
import 'package:movies/data/repository/app_repository.dart';
import 'package:movies/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (_) => MovieBloc(repository: AppRepository())..add(AppStarted()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Gallery',
        theme: ThemeData(primaryColor: Color(0xFF0A0A0A)),
        home: HomeScreen(),
      ),
    );
  }
}
