import 'package:domain/imports/module_imports.dart';
import 'package:domain/model/result.dart';

class MockDatabaseModel {
  static final movie = Movie(
    page: 1,
    totalPages: 3,
    totalResults: 4,
    results: [
      MovieResult(
        popularity: 5291.83,
        voteCount: 2,
        video: true,
        posterPath: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
        id: 2,
        adult: true,
        backdropPath: "/srYya1ZlI97Au4jUYAktDe3avyA.jpg",
        originalLanguage: "Eng",
        originalTitle: "originalTitle",
        genreIds: [1, 2, 3, 4],
        title: "Spider-man 2",
        overview: "overview",
        releaseDate: "Monday",
      )
    ],
  );

  static final nowPlayingMovies = NowPlayingMovie(
    totalPages: 3,
    totalResults: 4,
    results: [
      MovieResult(
        popularity: 5291.83,
        voteCount: 2,
        video: true,
        posterPath: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
        id: 2,
        adult: true,
        backdropPath: "/srYya1ZlI97Au4jUYAktDe3avyA.jpg",
        originalLanguage: "Eng",
        originalTitle: "originalTitle",
        genreIds: [1, 2, 3, 4],
        title: "Spider-man 2",
        overview: "overview",
        releaseDate: "Monday",
      )
    ],
  );

  static final movieList = List.generate(10, (i) => movie);
}
