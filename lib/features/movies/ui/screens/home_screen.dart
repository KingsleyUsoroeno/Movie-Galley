import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/data/bloc/movie/movie_category/movie_bloc.dart';
import 'package:movies/features/movies/data/bloc/movie/movie_category/movie_bloc_state.dart';
import 'package:movies/features/movies/data/bloc/movie/now_playing/now_playing_movies_bloc.dart';
import 'package:movies/features/movies/data/bloc/movie/now_playing/now_playing_movies_state.dart';
import 'package:movies/features/movies/data/bloc/movie/popular_movie/popular_movie_bloc.dart';
import 'package:movies/features/movies/data/bloc/movie/popular_movie/popular_movie_state.dart';
import 'package:movies/features/movies/data/remote/model/Result.dart';
import 'package:movies/features/movies/ui/screens/widgets/now_playing.dart';

import 'movies/now_playing_detail_screen.dart';
import 'widgets/custom_search_view.dart';
import 'widgets/movie_category.dart';

class HomeScreen extends StatelessWidget {
  Widget _buildMovieCategory(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieBlocState>(
      builder: (BuildContext context, MovieBlocState state) {
        if (state is MovieLoading) {
          return _buildProgressIndicator();
        } else if (state is MovieLoaded) {
          final movie = state.movie;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movie.results != null ? movie.results.length : 0,
            itemBuilder: (context, int index) {
              Results result = movie.results[index];
              return MovieCategory(movieResult: result);
            },
          );
        } else if (state is MovieError) {
          return _showErrorText(context, state.errorMessage);
        } else
          return Container();
      },
    );
  }

  Widget _buildNowPlaying(BuildContext context) {
    return BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      builder: (context, NowPlayingMoviesState state) {
        if (state is NowPlayingMovieLoading) {
          return _buildProgressIndicator();
        } else if (state is NowPlayingMovieLoaded) {
          // take 20 elements from the list and returns a new list
          final movies = state.nowPlayingMovies.results.take(20).toList();
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Now Playing', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
                  GestureDetector(
                      child: Text('View more', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                      onTap: () => _navigateToNowPlayingDetailScreen(context, state.nowPlayingMovies.results)),
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                  height: 170,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies != null ? movies.length : 0,
                    itemBuilder: (context, int index) {
                      Results result = movies[index];
                      return NowPlaying(nowPlayingResult: result);
                    },
                  )),
            ],
          );
        } else if (state is NowPlayingMovieError) {
          return _showErrorText(context, state.errorMessage);
        } else
          return Container();
      },
    );
  }

  Widget _showErrorText(BuildContext context, String errorMessage) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(errorMessage, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildPopularMovies(BuildContext context) {
    return BlocBuilder<PopularMovieBloc, PopularMovieState>(
      builder: (context, PopularMovieState state) {
        if (state is PopularMovieLoading) {
          return _buildProgressIndicator();
        } else if (state is PopularMovieLoaded) {
          final popularMovies = state.popularMovie;
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Popular Movies', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    child: Text('View more', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                    onTap: () => _navigateToPopularMoviesDetailScreen(context, popularMovies.results),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                  height: 170,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularMovies.results != null ? popularMovies.results.length : 0,
                    itemBuilder: (context, int index) {
                      Results result = popularMovies.results[index];
                      return NowPlaying(nowPlayingResult: result);
                    },
                  )),
            ],
          );
        } else if (state is PopularMovieError) {
          return _showErrorText(context, state.errorMessage);
        } else
          return Container(color: Colors.white);
      },
    );
  }

  Widget _buildProgressIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
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
                          style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
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
                      Container(height: 130, child: _buildMovieCategory(context)),
                      SizedBox(height: 20.0),
                      // NOW PLAYING MOVIES
                      _buildNowPlaying(context),
                      SizedBox(height: 20.0),
                      // POPULAR MOVIES
                      _buildPopularMovies(context)
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  void _navigateToNowPlayingDetailScreen(BuildContext context, List<Results> movies) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => BlocProvider.value(
          value: BlocProvider.of<NowPlayingMoviesBloc>(context), child: NowPlayingDetailScreen(movieResults: movies, tag: "")),
    ));
  }

  void _navigateToPopularMoviesDetailScreen(BuildContext context, List<Results> movies) {
//    Navigator.of(context).push(MaterialPageRoute(
//      builder: (_) =>
//          BlocProvider.value(value: BlocProvider.of<PopularMovieBloc>(context), child: MovieGrid(movieResults: movies, tag: "")),
//    ));
  }
}
