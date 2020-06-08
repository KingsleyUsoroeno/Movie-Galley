import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/utils.dart';
import 'package:movies/features/movies/data/bloc/movie/now_playing/bloc.dart';
import 'package:movies/features/movies/data/remote/model/Result.dart';

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
        builder: (context, NowPlayingMoviesState state) => _buildBody(state),
      ),
    );
  }

  bool _onScrollNotification(NowPlayingMoviesState state, ScrollNotification notification) {
    if (notification is ScrollEndNotification && _scrollController.position.extentAfter == 0) {
      print("Called to load more was called");
      context.bloc<NowPlayingMovieBloc>().add(FetchMoreMovies(loadMore: true));
    }
    return false;
  }

  Widget _buildBody(NowPlayingMoviesState state) {
    if (state is NowPlayingMovieLoaded) {
      return Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) => _onScrollNotification(state, notification),
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: state.nowPlayingMovies != null ? state.nowPlayingMovies.results.length : 0,
                  itemBuilder: (BuildContext context, int index) {
                    Results movieResult = state.nowPlayingMovies.results[index];
                    return Card(
                      child: Hero(
                        tag: movieResult.title,
                        child: Material(
                          child: GridTile(
                            footer: Container(
                              height: 30,
                              width: double.infinity,
                              color: Colors.black26,
                              child: Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: Text(movieResult.title,
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.0))),
                            ),
                            child: Utils.buildGridImage(movieResult),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    } else
      return Container();
  }
}
