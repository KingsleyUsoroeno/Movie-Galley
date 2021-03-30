import 'package:domain/model/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/bloc/now_playing/now_playing_movie_bloc.dart';
import 'package:movies/core/bloc/now_playing/now_playing_movies_event.dart';
import 'package:movies/core/bloc/now_playing/now_playing_movies_state.dart';
import 'package:movies/core/utils/utils.dart';
import 'package:movies/features/movies/ui/screens/movies/movie_detail.dart';

class NowPlayingDetailScreen extends StatelessWidget {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NowPlayingMovieBloc>(context);
    return BlocBuilder<NowPlayingMovieBloc, NowPlayingMoviesState>(
      bloc: bloc,
      builder: (_, state) {
        if (state is NowPlayingMovieLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text("NowPlaying"),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) =>
                          _onScrollNotification(bloc, notification),
                      child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: state.nowPlayingMovies.results.length,
                        itemBuilder: (_, int index) {
                          final MovieResult movieResult =
                              state.nowPlayingMovies.results[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => MovieDetail(
                                    movieResult: movieResult,
                                  ),
                                ),
                              );
                            },
                            child: Card(
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

  bool _onScrollNotification(
      NowPlayingMovieBloc bloc, ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      bloc.add(FetchMoreMovies(loadMore: true));
    }
    return false;
  }
}
