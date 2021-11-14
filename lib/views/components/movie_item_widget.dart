import 'package:domain/model/movie_result.dart';
import 'package:flutter/material.dart';
import 'package:movies/utils/utils.dart';
import 'package:movies/views/movies/movie_detail_screen.dart';

class MovieItemWidget extends StatelessWidget {
  final MovieResult nowPlayingResult;

  const MovieItemWidget({this.nowPlayingResult});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => MovieDetail(movieResult: nowPlayingResult),
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(6.0),
        width: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Utils.buildImage(nowPlayingResult),
            SizedBox(height: 10.0),
            Expanded(
              flex: 13,
              child: Text(
                nowPlayingResult.title,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 10,
              child: Row(
                children: <Widget>[
                  Icon(Icons.star, color: Colors.yellow[800], size: 16.0),
                  SizedBox(width: 6.0),
                  Text(
                    '8.2/10',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
