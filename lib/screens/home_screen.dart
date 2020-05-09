import 'package:flutter/material.dart';
import 'package:movies/data/model/Result.dart';
import 'package:movies/screens/home_view_model.dart';
import 'package:movies/screens/widgets/custom_search_view.dart';
import 'package:movies/screens/widgets/movie_category.dart';
import 'package:movies/screens/widgets/now_playing.dart';
import 'package:movies/screens/widgets/popular_movies.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (context, viewModel, child) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                body: ListView(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/daniel-craig.jpg"),
                              radius: 25.0,
                            ),
                          ),
                          Text(
                            'Hey, James Bond!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(right: 40.0),
                            child: Text('What would you like to watch today ?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold)),
                          ))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 30.0),
                      height: MediaQuery.of(context).size.height * 0.80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(40.0)),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // SEARCH VIEW
                          SearchView(),
                          SizedBox(height: 10.0),
                          viewModel.isMovieResponseLoading
                              ? Center(child: CircularProgressIndicator())
                              : Container(
                                  height: 130,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: viewModel.movieResponse != null
                                        ? viewModel.movieResponse.results.length
                                        : 0,
                                    itemBuilder: (context, int index) {
                                      Results result = viewModel
                                          .movieResponse.results[index];
                                      return MovieCategory(movieResult: result);
                                    },
                                  ),
                                ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Now Playing',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600)),
                              Text('View more',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          viewModel.isNowPlayingLoading
                              ? Center(child: CircularProgressIndicator())
                              : Container(
                                  height: 170,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        viewModel.nowPlayingResponse != null
                                            ? viewModel.nowPlayingResponse
                                                .results.length
                                            : 0,
                                    itemBuilder: (context, int index) {
                                      Results nowPlayingMovieResult = viewModel
                                          .nowPlayingResponse.results[index];
                                      return NowPlaying(
                                          nowPlayingResult:
                                              nowPlayingMovieResult);
                                    },
                                  ),
                                ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Popular Movies',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                              Text('View more',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            height: 170,
                            child: viewModel.isPopularMovieResponseLoading
                                ? Center(child: CircularProgressIndicator())
                                : Container(
                                    height: 130,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          viewModel.popularMovieResponse != null
                                              ? viewModel.popularMovieResponse
                                                  .results.length
                                              : 0,
                                      itemBuilder: (context, int index) {
                                        Results result = viewModel
                                            .popularMovieResponse
                                            .results[index];
                                        return PopularMovies(
                                            popularMovies: result);
                                      },
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          );
        },
        viewModelBuilder: () => HomeViewModel());
  }
}
