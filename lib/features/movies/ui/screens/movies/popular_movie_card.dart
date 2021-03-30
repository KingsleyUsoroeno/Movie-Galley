import 'package:domain/model/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movies/core/bloc/popular_movie/popular_movie_state.dart';
import 'package:movies/features/movies/ui/components/now_playing.dart';

class PopularMovieCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMovieBloc, PopularMovieState>(
      builder: (context, PopularMovieState state) {
        if (state is PopularMovieLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PopularMovieLoaded) {
          final popularMovies = state.popularMovie;
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Popular Movies',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    child: Text('View more',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w400)),
                    onTap: () => {},
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                  height: 170,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularMovies.results != null
                        ? popularMovies.results.length
                        : 0,
                    itemBuilder: (context, int index) {
                      MovieResult result = popularMovies.results[index];
                      return NowPlaying(nowPlayingResult: result);
                    },
                  )),
            ],
          );
        } else if (state is PopularMovieError) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text(
                state.errorMessage,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else
          return Container(color: Colors.white);
      },
    );
  }
}
