import 'package:domain/model/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/bloc/search_result_bloc/movie_search_bloc.dart';
import 'package:movies/core/bloc/search_result_bloc/movie_search_event.dart';
import 'package:movies/core/bloc/search_result_bloc/movie_search_state.dart';
import 'package:movies/features/movies/ui/components/search/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate()
      : super(searchFieldLabel: "Search For Movies Here e.g Avengers");

  final _suggestions = [
    "Fifty Shades of grey",
    "Boyka",
    "Spider Man",
    "Avengers",
    "Love me"
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Theme.of(context).primaryColor,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      primaryColorBrightness: Brightness.dark,
      textTheme: theme.textTheme.copyWith(
        headline6:
            TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show Search Results here
    print("inside custom search delegate and search query is $query");
    BlocProvider.of<MovieSearchBloc>(context, listen: false)
      ..add(SearchMovies(movieQuery: query));

    return BlocBuilder<MovieSearchBloc, MovieSearchState>(
      builder: (BuildContext context, MovieSearchState state) {
        if (state is MovieSearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieSearchLoaded) {
          final movie = state.movies;
          if (movie.results.isEmpty) {
            return _showErrorText("No Movie with that name Found");
          }
          return Container(
            child: ListView.builder(
              itemCount: movie.results != null ? movie.results.length : 0,
              itemBuilder: (context, int index) {
                MovieResult result = movie.results[index];
                return SearchResult(movieResult: result);
              },
            ),
          );
        } else if (state is MovieSearchError) {
          return _showErrorText(state.errorMessage);
        } else
          return Container();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 0) {
      return Container();
    }
    return ListView.separated(
      padding: EdgeInsets.all(10.0),
      itemCount: _suggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(
          _suggestions[index],
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(errorMessage,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
