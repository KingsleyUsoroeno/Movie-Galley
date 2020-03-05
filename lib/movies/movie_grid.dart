import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/movies/Result.dart';
import 'package:movies/movies/movies.dart';

import './movie_Detail.dart';

// create a function that fetches our list of movies from the
// MovieDb Api

Future<Movies> getAllMovies() async {
  final String url =
      "http://api.themoviedb.org/3/discover/movie?api_key=98d4ab8983c3a5727df9ab4f565f5f4a";
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    var m = Movies.fromJson(json.decode(response.body));
    print(m.results);
    return Movies.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

class MovieGrid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovieGridState();
  }
}

class MovieGridState extends State<MovieGrid> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                'Movies',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              backgroundColor: Colors.redAccent,
              centerTitle: true,
            ),
            body: FutureBuilder<Movies>(
              future: getAllMovies(),
              builder: (context, AsyncSnapshot<Movies> asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return _circularIndicator();
                } else if (asyncSnapshot.hasData) {
                  return _Movies(asyncSnapshot.data);
                } else {
                  print('async ${asyncSnapshot.data}');
                  return Center(child: Text('Couldnt fetch Movies',style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),));
                }
              },
            )));
  }

  // ignore: non_constant_identifier_names
  Widget _Movies(Movies movies) {
    final String imageUrl = 'https://image.tmdb.org/t/p/w500/';
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: movies != null ? movies.results.length : 0,
      itemBuilder: (BuildContext context, int index) {
        Results movieResult = movies.results[index];
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetail(movieResult))),
          child: Card(
            margin: EdgeInsets.all(3),
            child: Hero(
                tag: movieResult.title,
                child: Material(
                  child: GridTile(
                      footer: Container(
                        width: 400,
                        height: 400,
                        color: Colors.black26,
                        child: ListTile(
                          leading: Text(movieResult.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16.0)),
                        ),
                      ),
                      child: Image.network(imageUrl + movieResult.posterPath,
                          fit: BoxFit.cover)),
                )),
          ),
        );
      },
    );
  }

  Widget _circularIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
