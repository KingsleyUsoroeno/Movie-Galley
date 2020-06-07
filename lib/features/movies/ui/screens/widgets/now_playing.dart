import 'package:flutter/material.dart';
import 'package:movies/features/movies/data/remote/model/Result.dart';
import 'package:movies/features/movies/ui/screens/movies/movie_detail.dart';
import 'package:transparent_image/transparent_image.dart';

class NowPlaying extends StatelessWidget {
  final Results nowPlayingResult;

  NowPlaying({this.nowPlayingResult});

  final String imageUrl = 'https://image.tmdb.org/t/p/w500/';
  final String defaultImageUrl =
      "https://i0.wp.com/asiatimes.com/wp-content/uploads/2020/03/Screen-Shot-2020-03-02-at-11.37.50-AM.png?fit=850%2C486&ssl=1";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => MovieDetail(movieResult: nowPlayingResult))),
      child: Container(
        margin: EdgeInsets.all(6.0),
        width: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: nowPlayingResult.posterPath != null ? imageUrl + nowPlayingResult.posterPath : defaultImageUrl,
                      fit: BoxFit.cover,
                      width: 90),
                )),
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
                  Text('8.2/10', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
