import 'package:data/model/movie_entity.dart';
import 'package:data/model/now_playing_movie_entity.dart';
import 'package:data/model/popular_movie_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:remote/mapper/movie_remote_mapper.dart';
import 'package:remote/remote/movie_remote_impl.dart';

import 'mock_client.dart';

void main() {
  MockClient client;
  MovieRemoteImpl movieRemote;
  final String mockApiResponse =
      '{"page": 1,"total_results": 19832,"total_pages": 992,"results": [{"vote_count": 302,"id": 420818,"video": false,"vote_average": 6.8,"title": "The Lion King","popularity": 502.676,"poster_path": "/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg","original_language": "en","original_title": "The Lion King","genre_ids": [12,16,10751,18,28],"backdrop_path": "/1TUg5pO1VZ4B0Q1amk3OlXvlpXV.jpg","adult": false,"overview": "Simba idolises his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub\'s arrival. Scar, Mufasa\'s brother—and former heir to the throne—has plans of his own. The battle for Pride Rock is ravaged with betrayal, tragedy and drama, ultimately resulting in Simba\'s exile. With help from a curious pair of newfound friends, Simba will have to figure out how to grow up and take back what is rightfully his.","release_date": "2019-07-12"}]}';

  setUp(() {
    client = MockClient();
    movieRemote = MovieRemoteImpl(
        httpClient: client, movieRemoteMapper: MovieRemoteMapper());
  });

  group("MovieApiProvider test", () {
    test("returns a Movie response if the http call completes successfully",
        () async {
      when(client.get(Uri.parse(
              "https://api.themoviedb.org/3/discover/movie?api_key=98d4ab8983c3a5727df9ab4f565f5f4a")))
          .thenAnswer(
        (_) async => http.Response(
          mockApiResponse,
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        ),
      );
      expect(await movieRemote.fetchAllMovieCategories(), isA<MovieEntity>());
    });

    // Using throwsA is also a good idea as it lets you to be specific about what Exception you expected the function to throw if the logic was met
    test("throws an exception if the http call completes with an error",
        () async {
      when(client.get(Uri.parse(
              "https://api.themoviedb.org/3/discover/movie?api_key=98d4ab8983c3a5727df9ab4f565f5f4a")))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(movieRemote.fetchAllMovieCategories(), throwsException);
    });

    test(
        "returns a NowPlayingResponse response if the http call completes successfully",
        () async {
      when(client.get(Uri.parse(
              "https://api.themoviedb.org/3/movie/now_playing?api_key=98d4ab8983c3a5727df9ab4f565f5f4a&language=en-US&page=1")))
          .thenAnswer(
        (_) async => http.Response(
          mockApiResponse,
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        ),
      );
      expect(await movieRemote.fetchAllNowPlayingMovies(loadMore: false),
          isA<NowPlayingMovieEntity>());
    });

    test(
        "returns null response for fetching Now Playing Movies if the http call completes with an error",
        () async {
      when(client.get(Uri.parse(
              "https://api.themoviedb.org/3/movie/now_playing?api_key=98d4ab8983c3a5727df9ab4f565f5f4a&language=en-US&page=1")))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(await movieRemote.fetchAllNowPlayingMovies(loadMore: false),
          isA<Null>());
    });

    test(
        "calling getNowPlayingMovies with load more as true increments perNowPlayingPage value",
        () async {
      when(client.get(any)).thenAnswer(
        (_) async => http.Response(
          mockApiResponse,
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        ),
      );
      await movieRemote.fetchAllNowPlayingMovies(loadMore: true);

      expect(movieRemote.perNowPlayingPage, equals(2));
    });

    test(
        "returns a PopularMovie response if the http call completes successfully",
        () async {
      when(client.get(any)).thenAnswer(
        (_) async => http.Response(
          mockApiResponse,
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        ),
      );

      expect(await movieRemote.fetchPopularMovies(loadMore: false),
          isA<PopularMovieEntity>());
    });

    test(
        "calling get popular movies with load more as true increments perPopularMoviePage value",
        () async {
      when(client.get(any)).thenAnswer(
        (_) async => http.Response(
          mockApiResponse,
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        ),
      );
      await movieRemote.fetchPopularMovies(loadMore: true);

      expect(movieRemote.perPopularMoviePage, equals(2));
    });

    test(
        "throws an exception if the http call completes with"
        "an error while fetching popular movies", () async {
      when(client.get(any))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(movieRemote.fetchPopularMovies(loadMore: false), throwsException);
    });
  });
}
