import 'package:flutter/material.dart';
import 'package:movies/features/movies/data/remote/model/Result.dart';
import 'package:movies/features/movies/ui/screens/movies/movie_detail.dart';

class MovieCategory extends StatelessWidget {
  final Results movieResult;

  MovieCategory({this.movieResult});

  final String imageUrl = 'https://image.tmdb.org/t/p/w500/';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MovieDetail(
          movieResult: movieResult,
        ),
      )),
      child: Stack(
        children: <Widget>[
          Container(
            width: 200,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(imageUrl + movieResult.posterPath), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.2),
                  ]),
                  borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        movieResult.title,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
