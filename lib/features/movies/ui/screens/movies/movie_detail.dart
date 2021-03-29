import 'package:domain/model/result.dart';
import 'package:flutter/material.dart';

const boldTextStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

class MovieDetail extends StatelessWidget {
  final String imageUrl = 'https://image.tmdb.org/t/p/w500/';
  final MovieResult movieResult;

  MovieDetail({this.movieResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 350,
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 250.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                NetworkImage(imageUrl + movieResult.posterPath),
                            fit: BoxFit.cover)),
                    child: Container(
                      height: 350.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.white,
                              ],
                              stops: [
                                0.0,
                                1.0
                              ])),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 20.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      imageUrl + movieResult.posterPath),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Container(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: <Widget>[
                              Text(movieResult.title,
                                  style:
                                      boldTextStyle.copyWith(fontSize: 22.0)),
                              Text(
                                'Drama | Fantasy | Family',
                                style: boldTextStyle.copyWith(
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildReleaseBanner(),
                  SizedBox(height: 20.0),
                  Text("Story Line",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0)),
                  SizedBox(height: 10.0),
                  Text(movieResult.overview,
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16.0)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReleaseBanner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Release Date', style: boldTextStyle),
              SizedBox(height: 8.0),
              Text(movieResult.releaseDate),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Language', style: boldTextStyle),
              SizedBox(height: 8.0),
              Text(movieResult.originalLanguage),
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
