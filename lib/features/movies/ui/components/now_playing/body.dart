import 'package:domain/model/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/bloc/now_playing/now_playing_movie_bloc.dart';
import 'package:movies/core/bloc/now_playing/now_playing_movies_event.dart';
import 'package:movies/core/bloc/now_playing/now_playing_movies_state.dart';
import 'package:movies/core/utils.dart';
import 'package:movies/injection_container.dart';

class Body extends StatelessWidget {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingMovieBloc, NowPlayingMoviesState>(
      builder: (_, state) {
        if (state is NowPlayingMovieLoaded) {
          return Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) =>
                        _onScrollNotification(state, notification),
                    child: GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: state.nowPlayingMovies != null
                          ? state.nowPlayingMovies.results.length
                          : 0,
                      itemBuilder: (BuildContext context, int index) {
                        MovieResult movieResult =
                            state.nowPlayingMovies.results[index];
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
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 16.0))),
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
      },
    );
  }

  bool _onScrollNotification(
      NowPlayingMoviesState state, ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      print("Called to load more was called");
      injector.get<NowPlayingMovieBloc>().add(FetchMoreMovies(loadMore: true));
    }
    return false;
  }
}
