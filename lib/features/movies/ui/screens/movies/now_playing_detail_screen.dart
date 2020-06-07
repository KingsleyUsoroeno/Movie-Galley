import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/constant.dart';
import 'package:movies/features/movies/data/bloc/movie/now_playing/bloc.dart';
import 'package:movies/features/movies/data/remote/model/Result.dart';
import 'package:transparent_image/transparent_image.dart';

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
    List<Results> movieResults = widget.movieResults;
    return Scaffold(
      appBar: AppBar(
          title: Text("Now Playing Movies", style: TextStyle(fontSize: 18.0, color: Colors.white)),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true),
      body: BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(builder: (context, NowPlayingMoviesState state) {
        if (state is NowPlayingMovieLoaded) {
          return _buildBody(state);
        } else if (state is NowPlayingMovieLoadMore) {
          return _buildBody(state, movies: state.movies);
        } else
          return Container();
      }),
    );
  }

  bool _onScrollNotification(NowPlayingMoviesState state, ScrollNotification notification) {
    if (notification is ScrollEndNotification && _scrollController.position.extentAfter == 0) {
      print("Called to load more was called");
      context.bloc<NowPlayingMoviesBloc>().add(FetchMoreMovies(loadMore: true));
    }
    return false;
  }

  Widget _circularIndicator() {
    return Center(
      child: Center(
        child: new CircularProgressIndicator(),
      ),
    );
  }

  Column _buildBody(NowPlayingMoviesState state, {List<Results> movies}) {
    if (movies != null) {
      widget.movieResults.addAll(movies);
    }
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
                itemCount: widget.movieResults != null ? widget.movieResults.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  Results movieResult = widget.movieResults[index];
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
                          child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: movieResult.posterPath != null
                                  ? Constants.IMAGE_URL + movieResult.posterPath
                                  : Constants.DEFAULT_IMAGE_URL,
                              fit: BoxFit.cover,
                              width: 90),
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
  }
}
