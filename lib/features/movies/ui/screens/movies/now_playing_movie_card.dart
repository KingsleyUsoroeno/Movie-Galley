import 'package:domain/model/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/bloc/now_playing/now_playing_movie_bloc.dart';
import 'package:movies/core/bloc/now_playing/now_playing_movies_state.dart';
import 'package:movies/features/movies/ui/components/now_playing.dart';
import 'package:movies/features/movies/ui/screens/movies/now_playing_detail_screen.dart';

class NowPlayingMovieCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingMovieBloc, NowPlayingMoviesState>(
      builder: (context, NowPlayingMoviesState state) {
        if (state is NowPlayingMovieLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is NowPlayingMovieLoaded) {
          // take 20 elements from the list and returns a new list the Api returns a total of 20 Movies per page
          final movies = state.nowPlayingMovies.results.take(20).toList();
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Now Playing',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600)),
                  GestureDetector(
                      child: Text('View more',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w400)),
                      onTap: () => _navigateToNowPlayingDetailScreen(
                          context, state.nowPlayingMovies.results)),
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                  height: 170,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies != null ? movies.length : 0,
                    itemBuilder: (context, int index) {
                      MovieResult result = movies[index];
                      return NowPlaying(nowPlayingResult: result);
                    },
                  )),
            ],
          );
        } else if (state is NowPlayingMovieError) {
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
          return Container();
      },
    );
  }

  void _navigateToNowPlayingDetailScreen(
      BuildContext context, List<MovieResult> movies) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<NowPlayingMovieBloc>(context),
        child: NowPlayingDetailScreen(),
      ),
    ));
  }
}
