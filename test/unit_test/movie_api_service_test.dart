import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movies/features/movies/data/remote/model/movies.dart';
import 'package:movies/features/movies/data/service/movie_api_service_impl.dart';
import 'package:movies/features/movies/data/service/post.dart';

import 'mock_client.dart';

void main() {
  MockClient client;
  MovieApiServiceImpl movieApiService;

  setUp(() {
    client = MockClient();
    movieApiService = MovieApiServiceImpl(client: client);
  });

  String res =
      '{"page": 1,"total_results": 19832,"total_pages": 992,"results": [{"vote_count": 302,"id": 420818,"video": false,"vote_average": 6.8,"title": "The Lion King","popularity": 502.676,"poster_path": "/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg","original_language": "en","original_title": "The Lion King","genre_ids": [12,16,10751,18,28],"backdrop_path": "/1TUg5pO1VZ4B0Q1amk3OlXvlpXV.jpg","adult": false,"overview": "Simba idolises his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub\'s arrival. Scar, Mufasa\'s brother—and former heir to the throne—has plans of his own. The battle for Pride Rock is ravaged with betrayal, tragedy and drama, ultimately resulting in Simba\'s exile. With help from a curious pair of newfound friends, Simba will have to figure out how to grow up and take back what is rightfully his.","release_date": "2019-07-12"}]}';

  group("MovieApiProvider test", () {
    test("get movie categories success test", () async {
      when(client.get("http://api.themoviedb.org/3/discover/movie?api_key=98d4ab8983c3a5727df9ab4f565f5f4a")).thenAnswer(
        (_) async => http.Response(
          '{"page": 1,"total_results": 19832,"total_pages": 992,"results": [{"vote_count": 302,"id": 420818,"video": false,"vote_average": 6.8,"title": "The Lion King","popularity": 502.676,"poster_path": "/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg","original_language": "en","original_title": "The Lion King","genre_ids": [12,16,10751,18,28],"backdrop_path": "/1TUg5pO1VZ4B0Q1amk3OlXvlpXV.jpg","adult": false,"overview": "Simba idolises his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub\'s arrival. Scar, Mufasa\'s brother—and former heir to the throne—has plans of his own. The battle for Pride Rock is ravaged with betrayal, tragedy and drama, ultimately resulting in Simba\'s exile. With help from a curious pair of newfound friends, Simba will have to figure out how to grow up and take back what is rightfully his.","release_date": "2019-07-12"}]}',
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        ),
      );
      //when(client.get("http://api.themoviedb.org/3/discover/movie?api_key=98d4ab8983c3a5727df9ab4f565f5f4a")).thenAnswer((_) async => http.Response('{"title": "Test"}', 200));
      var result = await movieApiService.getMovieCategories();
      print(result);
      expect(await movieApiService.getMovieCategories(), isA<Movies>());
    });
  });

  test('returns a Movie response if the http call completes successfully', () async {
    // Use Mockito to return a successful response when it calls the
    // provided http.Client.
    when(client.get('https://jsonplaceholder.typicode.com/posts/1')).thenAnswer((_) async => http.Response('{"title": "Test"}', 200));

    expect(await movieApiService.getMovieCategories(), isA<Movies>());
  });

  test('returns a Post if the http call completes successfully', () async {
    final client = MockClient();

    // Use Mockito to return a successful response when it calls the
    // provided http.Client.
    when(client.get('https://jsonplaceholder.typicode.com/posts/1')).thenAnswer((_) async => http.Response('{"title": "Test"}', 200));

    expect(await fetchPost(client), isA<Post>());
  });

  test('throws an exception if the http call completes with an error', () {
    final client = MockClient();

    // Use Mockito to return an unsuccessful response when it calls the
    // provided http.Client.
    when(client.get('https://jsonplaceholder.typicode.com/posts/1')).thenAnswer((_) async => http.Response('Not Found', 404));

    expect(fetchPost(client), throwsException);
  });
}
