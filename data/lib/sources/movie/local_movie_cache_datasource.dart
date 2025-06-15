import 'dart:convert';

import 'package:domain/domain_dependencies.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LocalMovieCacheDataSource {
  final SharedPreferences _sharedPref;

  LocalMovieCacheDataSource(this._sharedPref);

  @visibleForTesting
  static const MovieCategoryKey = 'keys.movie_gallery.movie_category';

  @visibleForTesting
  static const NowPlayingMovieKey = 'keys.movie_gallery.now_playing';

  @visibleForTesting
  static const PopularMovieKey = 'keys.movie_gallery.popular_movies';

  Future<void> insert(MovieEntity movie) => switch (movie) {
    MovieCategoryEntity(:final results) => _saveMovie(MovieCategoryKey, results),
    PopularMovieEntity(:final results) => _saveMovie(PopularMovieKey, results),
    NowPlayingMovieEntity(:final results) => _saveMovie(NowPlayingMovieKey, results),
  };

  Future<void> _saveMovie(String key, List<MovieInfoEntity> movies) async {
    await _sharedPref.remove(key);
    await _sharedPref.setString(key, json.encode(List.from(movies.map((x) => x.toJson()))));
  }

  MovieCategoryEntity fetchMovieCategory() =>
      MovieCategoryEntity(results: _sharedPref.fetchMovieFromCache(MovieCategoryKey));

  NowPlayingMovieEntity fetchNowPlayingMovies() =>
      NowPlayingMovieEntity(results: _sharedPref.fetchMovieFromCache(NowPlayingMovieKey));

  PopularMovieEntity fetchPopularMovies() =>
      PopularMovieEntity(results: _sharedPref.fetchMovieFromCache(PopularMovieKey));
}

extension on SharedPreferences {
  List<MovieInfoEntity> fetchMovieFromCache(String key) {
    final result = getString(key);
    if (result case final result?) {
      return List<MovieInfoEntity>.from(json.decode(result).map((x) => MovieInfoEntity.fromJson(x)));
    }

    return [];
  }
}
