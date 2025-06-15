import 'package:domain/domain_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/now_playing_movies/cubit/now_playing_movies_cubit.dart';
import 'package:movies/utils/constant.dart';
import 'package:movies/movies/movie_detail_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class NowPlayingMovieDetailScreen extends StatefulWidget {
  @override
  State<NowPlayingMovieDetailScreen> createState() => _NowPlayingMovieDetailScreenState();
}

class _NowPlayingMovieDetailScreenState extends State<NowPlayingMovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
      bloc: context.read<NowPlayingMoviesCubit>(),
      builder: (_, state) {
        return Scaffold(
          body: switch (state) {
            NowPlayingMoviesSuccessState(:final movies) => _Content(movies),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}

class _Content extends StatefulWidget {
  const _Content(this.movies);

  final List<MovieInfoEntity> movies;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: NotificationListener<ScrollNotification>(
              onNotification: _onScrollNotification,
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: widget.movies.length,
                itemBuilder: (_, int index) {
                  final movie = widget.movies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => MovieDetail(movieInfo: movie)));
                    },
                    child: Card(
                      child: Hero(
                        tag: movie.title,
                        child: Material(
                          child: GridTile(
                            footer: Container(
                              height: 30,
                              width: double.infinity,
                              color: Colors.black26,
                              child: Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Text(
                                  movie.title,
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.0),
                                ),
                              ),
                            ),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: movie.moviePosterUrl,
                              fit: BoxFit.cover,
                              width: 90,
                              imageErrorBuilder: (_, _, _) {
                                return FadeInImage.assetNetwork(
                                  placeholder: Constants.OFFLINE_IMAGE_URL,
                                  image: Constants.OFFLINE_IMAGE_URL,
                                  fit: BoxFit.cover,
                                  width: 90,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification && _scrollController.position.extentAfter == 0) {
      context.read<NowPlayingMoviesCubit>().fetchMoreMovies();
    }
    return false;
  }
}
