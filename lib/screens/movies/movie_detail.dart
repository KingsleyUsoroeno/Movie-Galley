import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:movies/data/remote/model/Result.dart';

class MovieDetail extends StatelessWidget {
  final String imageUrl = 'https://image.tmdb.org/t/p/w500/';
  final Results movieResult;

  MovieDetail({this.movieResult});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Detail',
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(imageUrl + movieResult.posterPath, fit: BoxFit.cover),
            new BackdropFilter(
              filter: new ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: new Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: new Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: new Container(
                      width: double.infinity,
                      height: 450.0,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: new DecorationImage(image: NetworkImage(imageUrl + movieResult.posterPath), fit: BoxFit.cover)),
                    ),
                  ),
                  Expanded(
                    child: Text(movieResult.title, style: TextStyle(color: Colors.white, fontSize: 30.0, fontFamily: 'Arvo')),
                  ),
                  Expanded(
                    child: Text(movieResult.overview, style: TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: 'Arvo')),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
