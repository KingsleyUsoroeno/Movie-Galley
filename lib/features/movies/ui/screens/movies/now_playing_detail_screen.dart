import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/data/bloc/movie/now_playing/bloc.dart';
import 'package:movies/features/movies/data/remote/model/Result.dart';
import 'package:movies/features/movies/ui/components/now_playing/body.dart';

class NowPlayingDetailScreen extends StatefulWidget {
  final List<Results> movieResults;
  final String tag;

  NowPlayingDetailScreen({this.movieResults, this.tag});

  @override
  _NowPlayingDetailScreenState createState() => _NowPlayingDetailScreenState();
}

class _NowPlayingDetailScreenState extends State<NowPlayingDetailScreen> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Now Playing Movies", style: TextStyle(fontSize: 18.0, color: Colors.white)),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true),
      body: BlocBuilder<NowPlayingMovieBloc, NowPlayingMoviesState>(
        builder: (context, NowPlayingMoviesState state) => Body(),
      ),
    );
  }
}
