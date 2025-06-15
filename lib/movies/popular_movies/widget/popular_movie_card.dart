import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/popular_movies/cubit/popular_movies_cubit.dart';
import 'package:movies/movies/movie_item_widget.dart';

class PopularMovieCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMoviesCubit, PopularMoviesState>(
      builder: (context, PopularMoviesState state) {
        return switch (state) {
          PopularMoviesInitialState() => const SizedBox.shrink(),
          PopularMoviesLoadingState() => Center(child: CircularProgressIndicator()),
          PopularMoviesSuccessState(:final movies) => Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Popular Movies', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    child: Text('View more', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                    onTap: () => {},
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, int index) {
                    return MovieItemWidget(movieInfo: movies[index]);
                  },
                ),
              ),
            ],
          ),
          PopularMoviesFailureState(:final message) => ColoredBox(
            color: Colors.white,
            child: Center(child: Text(message, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
          ),
        };
      },
    );
  }
}
