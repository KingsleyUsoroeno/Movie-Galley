import 'package:domain/domain_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies/movie_detail_screen.dart';
import 'package:movies/utils/constant.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieItemWidget extends StatelessWidget {
  final MovieInfoEntity movieInfo;

  const MovieItemWidget({required this.movieInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => MovieDetail(movieInfo: movieInfo))),
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
                  image: movieInfo.moviePosterUrl,
                  fit: BoxFit.cover,
                  width: 90,
                  imageErrorBuilder: (_, _, _) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: FadeInImage.assetNetwork(
                        image: Constants.OFFLINE_IMAGE_URL,
                        placeholder: Constants.OFFLINE_IMAGE_URL,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              flex: 13,
              child: Text(
                movieInfo.title,
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
            ),
          ],
        ),
      ),
    );
  }
}
