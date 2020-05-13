import 'package:flutter/material.dart';
import 'package:movies/screens/viewmodel/load_more_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../data/model/Result.dart';

class MovieGrid extends StatelessWidget {
  final List<Results> movieResults;
  final String tag;
  final _scrollController = ScrollController();

  MovieGrid({this.movieResults, this.tag});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoadMoreViewModel>.reactive(
      builder: (context, viewModel, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
          home: Scaffold(
            appBar: AppBar(
              title: Text(
                tag,
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
              centerTitle: true,
            ),
            body: _buildMovies(viewModel, movieResults, _scrollController, movieResults),
          ),
        );
      },
      viewModelBuilder: () => LoadMoreViewModel(),
    );
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

Widget _buildMovies(LoadMoreViewModel viewModel, List<Results> movieResults, ScrollController controller, List<Results> results) {
  final String imageUrl = 'https://image.tmdb.org/t/p/w500/';
  return Column(
    children: <Widget>[
      Expanded(
        child: Container(
          width: 400,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) => _onScrollNotification(viewModel, notification, controller, results),
            child: GridView.builder(
              controller: controller,
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
                          child: Image.network(imageUrl + movieResult.posterPath, fit: BoxFit.cover)),
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
  );
}

bool _onScrollNotification(LoadMoreViewModel viewModel, ScrollNotification notification, ScrollController controller,
    List<Results> results) {
  if (notification is ScrollEndNotification && controller.position.extentAfter == 0) {
    viewModel.loadMoreMovies(loadMore: true, results: results);
    print("Called to load more was called");
  }
  return false;
}
