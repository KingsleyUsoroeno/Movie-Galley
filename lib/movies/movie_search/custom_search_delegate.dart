import 'package:domain/domain_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/movie_search/cubit/movie_search_cubit.dart';
import 'package:movies/utils/constant.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: "Search For Movies Here e.g Avengers");

  final _suggestions = ["Fifty Shades of grey", "Boyka", "Spider Man", "Avengers", "Love me"];

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Theme.of(context).primaryColor,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      textTheme: theme.textTheme.copyWith(
        headlineMedium: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
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
    context.read<MovieSearchCubit>().search(query);

    return BlocBuilder<MovieSearchCubit, MovieSearchState>(
      builder:
          (context, state) => switch (state) {
            MovieSearchInitialState() => const SizedBox.shrink(),
            MovieSearchLoadingState() => Center(child: CircularProgressIndicator()),
            MovieSearchSuccessState(:final movies) => ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, int index) {
                return _SearchResultContent(movies[index]);
              },
            ),
            MovieSearchFailureState(:final message) => ColoredBox(
              color: Colors.white,
              child: Center(child: Text(message ?? '', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
            ),
          },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return SizedBox.shrink();
    }
    return ListView.separated(
      padding: EdgeInsets.all(10.0),
      itemCount: _suggestions.length,
      itemBuilder: (_, int index) {
        return Text(_suggestions[index], style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400));
      },
      separatorBuilder: (_, _) => const Divider(),
    );
  }
}

class _SearchResultContent extends StatelessWidget {
  const _SearchResultContent(this.movie);

  final MovieInfoEntity movie;

  @override
  Widget build(BuildContext context) {
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
                image:
                    movie.posterPath != null
                        ? "${Constants.IMAGE_URL}${movie.posterPath}"
                        : Constants.DEFAULT_IMAGE_URL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(movie.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(movie.overview, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}
