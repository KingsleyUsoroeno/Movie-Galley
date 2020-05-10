import 'package:flutter/material.dart';

import '../../data/model/Result.dart';

class MovieGrid extends StatelessWidget {
  final List<Results> movieResults;
  final String tag;

  MovieGrid({this.movieResults, this.tag});

  @override
  Widget build(BuildContext context) {
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
        body: _buildMovies(movieResults),
      ),
    );
  }
}

Widget _circularIndicator() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget _buildMovies(List<Results> movieResults) {
  final String imageUrl = 'https://image.tmdb.org/t/p/w500/';
  return Container(
    width: 400,
    child: GridView.builder(
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
                    padding: EdgeInsets.all(8.0),
                    height: 30,
                    width: double.infinity,
                    color: Colors.black26,
                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Text(movieResult.title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.0))),
                  ),
                  child: Image.network(imageUrl + movieResult.posterPath, fit: BoxFit.cover)),
            ),
          ),
        );
      },
    ),
  );
}
