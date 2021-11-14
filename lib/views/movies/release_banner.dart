import 'package:domain/model/movie_result.dart';
import 'package:flutter/material.dart';

class ReleaseBanner extends StatelessWidget {
  final TextStyle boldTextStyle;
  final MovieResult movie;

  const ReleaseBanner({
    Key key,
    @required this.boldTextStyle,
    @required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Release Date', style: boldTextStyle),
              SizedBox(height: 8.0),
              Text(movie.releaseDate),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Language', style: boldTextStyle),
              SizedBox(height: 8.0),
              Text(movie.originalLanguage),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Subtitles', style: boldTextStyle),
              SizedBox(height: 8.0),
              Text('English')
            ],
          ),
        ),
      ],
    );
  }
}
