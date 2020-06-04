import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/data/bloc/movie_state.dart';
import 'package:movies/data/bloc/movies_bloc.dart';
import 'package:movies/screens/widgets/now_playing.dart';
import 'package:movies/screens/widgets/popular_movies.dart';

import '../data/remote/model/Result.dart';
import 'movies/movie_grid.dart';
import 'widgets/custom_search_view.dart';
import 'widgets/movie_category.dart';

// Todo test Offline and online functionalities and work on image rendering when offline
class HomeScreen extends StatelessWidget {
  Widget _buildMovieCategory(MovieState state) {
    // loading state
    if (state is MoviesLoading) {
      return _buildProgressIndicator();
    } else if (state is MoviesCategoryLoaded) {
      final movie = state.movies;
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movie.results != null ? movie.results.length : 0,
        itemBuilder: (context, int index) {
          Results result = movie.results[index];
          return MovieCategory(movieResult: result);
        },
      );
    } else if (state is MoviesError) {
      return _showErrorText(state.errorMessage);
    } else
      return Container();
  }

  Widget _buildNowPlaying(MovieState state) {
    if (state is MoviesLoading) {
      return _buildProgressIndicator();
    } else if (state is NowPlayingMoviesLoaded) {
      final popularMovies = state.nowPlayingMovies;
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: popularMovies.results != null ? popularMovies.results.length : 0,
        itemBuilder: (context, int index) {
          Results result = popularMovies.results[index];
          return NowPlaying(nowPlayingResult: result);
        },
      );
    } else if (state is MoviesError) {
      return _showErrorText(state.errorMessage);
    } else
      return Container();
  }

  Widget _showErrorText(String errorMessage) {
    return Center(
      child: Text(errorMessage, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildPopularMovies(MovieState state) {
    // loading state
    if (state is MoviesLoading) {
      return _buildProgressIndicator();
    } else if (state is PopularMoviesLoaded) {
      final nowPlayingMovies = state.popularMovie;
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: nowPlayingMovies.results != null ? nowPlayingMovies.results.length : 0,
        itemBuilder: (context, int index) {
          Results result = nowPlayingMovies.results[index];
          return PopularMovies(popularMovies: result);
        },
      );
    } else if (state is MoviesError) {
      return _showErrorText(state.errorMessage);
    } else
      return Container();
  }

  Widget _buildProgressIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            return SingleChildScrollView(
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
                        Container(height: 130, child: _buildMovieCategory(state)),
                        SizedBox(height: 20.0),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                          Text('Now Playing', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
                          GestureDetector(
                              child: Text('View more', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                              onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => MovieGrid(
                                        movieResults: [],
                                        tag: "Now Playing",
                                      ),
                                    ),
                                  )),
                        ]),
                        SizedBox(height: 8.0),
                        Container(height: 170, child: _buildNowPlaying(state)),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Popular Movies', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            GestureDetector(
                              child: Text('View more', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => MovieGrid(movieResults: [], tag: "Popular Movies"),
                              )),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Container(height: 170, child: _buildPopularMovies(state)),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
