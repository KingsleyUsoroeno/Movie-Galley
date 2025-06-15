import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/movie_categories/cubit/movie_category_cubit.dart';
import 'package:movies/movies/now_playing_movies/cubit/now_playing_movies_cubit.dart';
import 'package:movies/movies/now_playing_movies/widget/now_playing_movie_card.dart';
import 'package:movies/movies/popular_movies/widget/popular_movie_card.dart';
import 'package:movies/movies/movie_search/custom_search_delegate.dart';
import 'package:movies/movies/movie_search/movie_search_field.dart';
import 'package:movies/movies/movie_categories/movie_category_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        context.read<MovieCategoryCubit>().initialize();
        context.read<NowPlayingMoviesCubit>().initialize();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  height: size.height * 0.25,
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
                      Text(
                        'Hey, James Bond!',
                        style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 40.0),
                          child: Text(
                            'What would you like to watch today ?',
                            style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // SEARCH VIEW
                      MovieSearchField(
                        onSearchFieldTapped: () {
                          showSearch(context: context, delegate: CustomSearchDelegate());
                        },
                      ),
                      SizedBox(height: 10.0),
                      Container(height: 130, child: MovieCategoryCard()),
                      SizedBox(height: 20.0),
                      // NOW PLAYING MOVIES
                      NowPlayingMovieCard(),
                      SizedBox(height: 20.0),
                      // POPULAR MOVIES
                      PopularMovieCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
