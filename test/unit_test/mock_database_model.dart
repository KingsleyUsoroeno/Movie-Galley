import 'package:movies/features/movies/data/local/database/model/movie_model.dart';
import 'package:movies/features/movies/data/local/database/model/now_playing_movies_model.dart';
import 'package:movies/features/movies/data/remote/model/Result.dart';

class MockDatabaseModel {
  static final movie = MovieDatabaseModel(
    id: 1,
    page: 1,
    totalPages: 3,
    totalResults: 4,
    results: [
      Results(
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

  static final nowPlayingMovies = NowPlayingMoviesDatabaseModel(
    id: 1,
    totalPages: 3,
    totalResults: 4,
    results: [
      Results(
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
}
