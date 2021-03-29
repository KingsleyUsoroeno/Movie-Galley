import 'package:flutter/material.dart';
import 'package:movies/core/bloc/movie_category/bloc.dart';
import 'package:movies/core/bloc/movie_category/movie_bloc.dart';
import 'package:movies/core/bloc/now_playing/now_playing_movie_bloc.dart';
import 'package:movies/core/bloc/now_playing/now_playing_movies_event.dart';
import 'package:movies/features/movies/ui/components/custom_search_delegate.dart';
import 'package:movies/features/movies/ui/components/custom_search_view.dart';
import 'package:movies/features/movies/ui/screens/movies/movie_category_card.dart';
import 'package:movies/features/movies/ui/screens/movies/now_playing_movie_card.dart';
import 'package:movies/injection_container.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        injector.get<MovieBloc>().add(RefreshMovies());
        injector.get<NowPlayingMovieBloc>().add(RefreshNowPlayingMovies());
        //injector.get<PopularMovieBloc>().add(RefreshPopularMovies());
      },
      child: SafeArea(
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
                          backgroundImage:
                              AssetImage("assets/images/daniel-craig.jpg"),
                          radius: 25.0,
                        ),
                      ),
                      Text('Hey, James Bond!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                      SizedBox(height: 10),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 40.0),
                          child: Text('What would you like to watch today ?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(40.0)),
                      color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // SEARCH VIEW
                      SearchView(showSearchCallback: () {
                        showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(),
                        );
                      }),
                      SizedBox(height: 10.0),
                      Container(height: 130, child: MovieCategoryCard()),
                      SizedBox(height: 20.0),
                      // NOW PLAYING MOVIES
                      NowPlayingMovieCard(),
                      SizedBox(height: 20.0),
                      // POPULAR MOVIES
                      //PopularMovieCard()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
