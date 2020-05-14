import 'package:flutter/material.dart';
import 'package:movies/screens/movies/movie_grid.dart';
import 'package:movies/screens/viewmodel/home_view_model.dart';
import 'package:stacked/stacked.dart';

import '../data/model/Result.dart';
import 'viewmodel/home_view_model.dart';
import 'widgets/custom_search_view.dart';
import 'widgets/movie_category.dart';
import 'widgets/now_playing.dart';
import 'widgets/popular_movies.dart';

class HomeScreen extends StatelessWidget {
  Widget _buildMovieCategory(HomeViewModel viewModel) {
    // loading state
    if (viewModel.isMovieResponseLoading) {
      return _buildProgressIndicator();
    }
    if (viewModel.didFetchMovieCategory) {
      // success state
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.movieResponse != null ? viewModel.movieResponse.results.length : 0,
        itemBuilder: (context, int index) {
          Results result = viewModel.movieResponse.results[index];
          return MovieCategory(movieResult: result);
        },
      );
    } else {
      // error state
      return _showErrorText(viewModel.movieCategoryNetworkExceptionMessage);
    }
  }

  Widget _buildNowPlaying(HomeViewModel viewModel) {
    // loading state
    if (viewModel.isNowPlayingLoading) {
      return _buildProgressIndicator();
    }
    if (viewModel.didFetchNowPlaying) {
      // success state
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.nowPlayingResponse != null ? viewModel.nowPlayingResponse.results.length : 0,
        itemBuilder: (context, int index) {
          Results nowPlayingMovieResult = viewModel.nowPlayingResponse.results[index];
          return NowPlaying(nowPlayingResult: nowPlayingMovieResult);
        },
      );
    } else {
      // error state
      return _showErrorText(viewModel.nowPlayingNetworkExceptionMessage);
    }
  }

  Widget _showErrorText(String errorMessage) {
    return Center(
      child: Text(errorMessage, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPopularMovies(HomeViewModel viewModel) {
    // loading state
    if (viewModel.isPopularMovieResponseLoading) {
      return _buildProgressIndicator();
    }
    if (viewModel.didFetchPopularMovies) {
      // success state
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.popularMovieResponse != null ? viewModel.popularMovieResponse.results.length : 0,
        itemBuilder: (context, int index) {
          Results result = viewModel.popularMovieResponse.results[index];
          return PopularMovies(popularMovies: result);
        },
      );
    } else {
      // error state
      return _showErrorText(viewModel.popularMoviesNetworkExceptionMessage);
    }
  }

  Widget _buildProgressIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (context, viewModel, child) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              backgroundImage: AssetImage("assets/images/daniel-craig.jpg"),
                              radius: 25.0,
                            ),
                          ),
                          Text('Hey, James Bond!',
                              style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center),
                          SizedBox(height: 10),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 40.0),
                              child: Text('What would you like to watch today ?',
                                  style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0)), color: Colors.white),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // SEARCH VIEW
                          SearchView(),
                          SizedBox(height: 10.0),
                          Container(height: 130, child: _buildMovieCategory(viewModel)),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Now Playing', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
                              GestureDetector(
                                child: Text('View more', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => MovieGrid(
                                    movieResults: viewModel.nowPlayingResponse.results,
                                    tag: "Now Playing",
                                  ),
                                )),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Container(height: 170, child: _buildNowPlaying(viewModel)),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Popular Movies', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                              GestureDetector(
                                child: Text('View more', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => MovieGrid(movieResults: viewModel.popularMovieResponse.results, tag: "Popular Movies"),
                                )),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(height: 170, child: _buildPopularMovies(viewModel)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => HomeViewModel());
  }
}
