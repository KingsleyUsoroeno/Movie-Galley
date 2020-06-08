import 'package:flutter/material.dart';
import 'package:movies/core/constant.dart';
import 'package:movies/core/network_info.dart';
import 'package:movies/features/movies/data/remote/model/Result.dart';
import 'package:movies/features/movies/ui/screens/movies/movie_detail.dart';
import 'package:movies/injection_container.dart';
import 'package:transparent_image/transparent_image.dart';

class PopularMovies extends StatelessWidget {
  final Results popularMovies;

  PopularMovies({this.popularMovies});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => MovieDetail(movieResult: popularMovies))),
      child: Container(
        margin: EdgeInsets.all(6.0),
        width: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildImage(),
            SizedBox(height: 10.0),
            Expanded(
              flex: 13,
              child: Text(
                popularMovies.title,
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

  Widget _buildImage() {
    final networkInfo = injector<NetworkInfo>();
    return FutureBuilder<bool>(
      future: networkInfo.isConnected,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return Expanded(
            flex: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage, image: Constants.IMAGE_URL + popularMovies.posterPath, fit: BoxFit.cover, width: 90),
            ),
          );
        } else if (snapshot.data == false) {
          return Expanded(
            flex: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage.assetNetwork(image: Constants.OFFLINE_IMAGE_URL, placeholder: Constants.OFFLINE_IMAGE_URL),
            ),
          );
        }
        return Center();
      },
    );
  }
}
