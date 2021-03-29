import 'package:domain/model/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/bloc/movie_category/movie_bloc.dart';
import 'package:movies/core/bloc/movie_category/movie_state.dart';
import 'package:movies/features/movies/ui/components/movie_category.dart';

class MovieCategoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (BuildContext context, MovieState state) {
        if (state is MovieLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MovieLoaded) {
          final movie = state.movie;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movie.results != null ? movie.results.length : 0,
            itemBuilder: (context, int index) {
              MovieResult result = movie.results[index];
              return MovieCategory(movieResult: result);
            },
          );
        } else if (state is MovieError) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Text(state.errorMessage,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
          );
        } else
          return Container();
      },
    );
  }
}
