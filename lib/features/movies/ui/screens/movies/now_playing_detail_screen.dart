import 'package:domain/model/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/bloc/now_playing/now_playing_movie_bloc.dart';
import 'package:movies/core/bloc/now_playing/now_playing_movies_event.dart';
import 'package:movies/core/bloc/now_playing/now_playing_movies_state.dart';
import 'package:movies/core/utils.dart';
import 'package:movies/injection_container.dart';

class NowPlayingDetailScreen extends StatelessWidget {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingMovieBloc, NowPlayingMoviesState>(
      bloc: BlocProvider.of<NowPlayingMovieBloc>(context),
      builder: (_, state) {
        if (state is NowPlayingMovieLoaded) {
          return Scaffold(
            appBar: AppBar(),
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: _onScrollNotification,
                      child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: state.nowPlayingMovies.results.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(
                              "inside view and state count is ${state.nowPlayingMovies.results.length}");
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
                                        alignment:
                                            FractionalOffset.bottomCenter,
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
            ),
          );
        } else
          return Container();
      },
    );
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      injector.get<NowPlayingMovieBloc>().add(FetchMoreMovies(loadMore: true));
    }
    return false;
  }
}
