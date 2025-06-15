import 'package:domain/domain_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/movie_categories/cubit/movie_category_cubit.dart';
import 'package:movies/movies/movie_detail_screen.dart';
import 'package:movies/utils/constant.dart';

class MovieCategoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieCategoryCubit, MovieCategoryState>(
      builder:
          (context, state) => switch (state) {
            MovieCategoryInitialState() => const SizedBox.shrink(),
            MovieCategoryLoadingState() => Center(child: CircularProgressIndicator()),
            MovieCategorySuccessState(:final movies) => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (_, int index) {
                return _MovieItemTile(movies[index]);
              },
            ),
            MovieCategoryFailureState(:final message) => ColoredBox(
              color: Colors.white,
              child: Center(child: Text(message ?? '', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
            ),
          },
    );
  }
}

class _MovieItemTile extends StatelessWidget {
  const _MovieItemTile(this.movieEntity);

  final MovieInfoEntity movieEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => MovieDetail(movieInfo: movieEntity))),
      child: Stack(
        children: <Widget>[
          Container(
            width: 200,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('${Constants.IMAGE_URL}${movieEntity.posterPath}'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  colors: [Colors.black.withOpacity(0.8), Colors.black.withOpacity(0.2)],
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        movieEntity.title,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
