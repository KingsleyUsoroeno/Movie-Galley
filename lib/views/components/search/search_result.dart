import 'package:domain/model/movie_result.dart';
import 'package:flutter/material.dart';
import 'package:movies/utils/constant.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchResult extends StatelessWidget {
  final MovieResult movieResult;

  const SearchResult({this.movieResult});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 300,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: movieResult.posterPath != null
                      ? Constants.IMAGE_URL + movieResult.posterPath
                      : Constants.DEFAULT_IMAGE_URL,
                  fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movieResult.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movieResult.overview,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }
}
