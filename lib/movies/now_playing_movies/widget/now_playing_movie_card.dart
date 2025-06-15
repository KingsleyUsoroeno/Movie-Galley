import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/now_playing_movies/cubit/now_playing_movies_cubit.dart';
import 'package:movies/movies/movie_item_widget.dart';

import '../now_playing_movie_detail_screen.dart';

class NowPlayingMovieCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
      bloc: BlocProvider.of<NowPlayingMoviesCubit>(context),
      builder: (context, NowPlayingMoviesState state) {
        return switch (state) {
          NowPlayingMoviesInitialState() => const SizedBox.shrink(),
          NowPlayingMoviesLoadingState() => Center(child: CircularProgressIndicator()),
          NowPlayingMoviesSuccessState(:final movies) => Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Now Playing', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
                  GestureDetector(
                    child: Text('View more', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => NowPlayingMovieDetailScreen()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (_, int index) {
                    return MovieItemWidget(movieInfo: movies[index]);
                  },
                ),
              ),
            ],
          ),
          NowPlayingMoviesFailureState(:final message) => ColoredBox(
            color: Colors.white,
            child: Center(
              child: Text(
                message ?? 'Something went wrong',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        };
      },
    );
  }
}
