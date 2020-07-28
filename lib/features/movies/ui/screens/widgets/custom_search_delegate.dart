import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/constant.dart';
import 'package:movies/features/movies/data/bloc/movie/search_result_bloc/bloc.dart';
import 'package:movies/features/movies/data/bloc/movie/search_result_bloc/movie_search_bloc.dart';
import 'package:movies/features/movies/data/bloc/movie/search_result_bloc/movie_search_event.dart';
import 'package:movies/features/movies/data/remote/model/Result.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: "Search For Movies Here e.g Avengers");

  final _suggestions = ["Fifty Shades of grey", "Boyka", "Spider Man", "Avengers", "Love me"];

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
        headline6: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
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
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show Search Results here
    print("inside custom search delegate and search query is $query");
    context.bloc<MovieSearchBloc>().add(SearchMovies(movieQuery: query));

    return BlocBuilder<MovieSearchBloc, MovieSearchState>(
      builder: (BuildContext context, MovieSearchState state) {
        if (state is MovieSearchLoading) {
          return _buildLoadingSpinner();
        } else if (state is MovieSearchLoaded) {
          final movie = state.movies;
          if (movie.results.isEmpty) {
            return _showErrorText("No Movie with that name Found");
          }
          return Container(
            child: ListView.builder(
              itemCount: movie.results != null ? movie.results.length : 0,
              itemBuilder: (context, int index) {
                Results result = movie.results[index];
                return _buildMovieCategory(result);
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

  Widget _buildLoadingSpinner() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(errorMessage, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

Widget _buildMovieCategory(Results movieResult) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    elevation: 2.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 300,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: movieResult.posterPath != null ? Constants.IMAGE_URL + movieResult.posterPath : Constants.DEFAULT_IMAGE_URL,
                fit: BoxFit.cover),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            movieResult.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            movieResult.overview,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
          ),
        )
      ],
    ),
  );
}
