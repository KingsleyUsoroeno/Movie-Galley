import 'package:flutter/material.dart';
import 'package:movies/screens/viewmodel/load_more_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../data/remote/model/Result.dart';

class MovieGrid extends StatefulWidget {
  final List<Results> movieResults;
  final String tag;

  MovieGrid({this.movieResults, this.tag});

  @override
  _MovieGridState createState() => _MovieGridState();
}

class _MovieGridState extends State<MovieGrid> {
  final _scrollController = ScrollController();
  final String _imageUrl = 'https://image.tmdb.org/t/p/w500/';

  @override
  Widget build(BuildContext context) {
    List<Results> movieResults = widget.movieResults;
    return ViewModelBuilder<LoadMoreViewModel>.reactive(
      builder: (context, viewModel, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
          home: Scaffold(
            appBar: AppBar(
                title: Text(widget.tag, style: TextStyle(fontSize: 18.0, color: Colors.white)),
                backgroundColor: Theme.of(context).primaryColor,
                centerTitle: true),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) => _onScrollNotification(viewModel, notification),
                      child: GridView.builder(
                        controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemCount: movieResults != null ? movieResults.length : 0,
                        itemBuilder: (BuildContext context, int index) {
                          Results movieResult = movieResults[index];
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
                                    child: Image.network(_imageUrl + movieResult.posterPath, fit: BoxFit.cover)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                _circularIndicator(viewModel.loadMore)
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => LoadMoreViewModel(),
    );
  }

  bool _onScrollNotification(LoadMoreViewModel viewModel, ScrollNotification notification) {
    if (notification is ScrollEndNotification && _scrollController.position.extentAfter == 0) {
      print("Called to load more was called");
      switch (widget.tag) {
        case "Now Playing":
          viewModel.loadMoreNowPlayingMovie(loadMore: true, results: widget.movieResults);
          break;

        case "Popular Movies":
          viewModel.loadMorePopularMovies(loadMore: true, results: widget.movieResults);
          break;
      }
    }
    return false;
  }
}

Widget _circularIndicator(bool isLoading) {
  return Container(
    height: isLoading ? 50.0 : 0,
    color: Colors.transparent,
    child: Center(
      child: new CircularProgressIndicator(),
    ),
  );
}
