// import 'package:data/model/movie_entity.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';
// import 'package:remote/mapper/movie_remote_mapper.dart';
// import 'package:remote/remote/sources/movies/movie_remote_datasource_impl.dart';
//
// import 'json_parser.dart';
// import 'mock_client.dart';
//
// void main() {
//   MockClient client;
//   MovieRemoteImpl movieRemote;
//   JsonParser jsonParser;
//
//   setUp(() {
//     client = MockClient();
//     movieRemote = MovieRemoteImpl(
//       httpClient: client,
//       movieRemoteMapper: MovieRemoteMapper(),
//     );
//     jsonParser = JsonParser();
//   });
//
//   group("MovieApiProvider test", () {
//     test("returns a Movie response if the http call completes successfully",
//         () async {
//       final response = await jsonParser
//           .getMockJsonFile("test/api_response/movie_response.json");
//
//       when(client.get(Uri.parse("https://api.themoviedb.org/3/discover/movie?"
//               "api_key=98d4ab8983c3a5727df9ab4f565f5f4a")))
//           .thenAnswer(
//         (_) async => http.Response(
//           response,
//           200,
//           headers: {'content-type': 'application/json; charset=utf-8'},
//         ),
//       );
//       expect(await movieRemote.fetchMovieCategories(), isA<MovieEntity>());
//     });
//
//     // Using throwsA is also a good idea as it lets you to be specific about
//     // what Exception you expected the function to throw if the logic was met
//     test("throws an exception if the http call completes with an error",
//         () async {
//           when(client.get(Uri.parse(
//               "https://api.themoviedb.org/3/discover/movie?api_key=98d4ab8983c3a5727df9ab4f565f5f4a")))
//           .thenAnswer((_) async => http.Response('Not Found', 404));
//       expect(movieRemote.fetchMovieCategories(), throwsException);
//     });
//
//     test(
//         "returns a NowPlayingResponse response if the http call "
//         "completes successfully", () async {
//       final response = await jsonParser
//           .getMockJsonFile("test/api_response/now_playing_movie_response.json");
//
//       when(client.get(Uri.parse("https://api.themoviedb.org/3/movie/now_playing"
//               "?api_key=98d4ab8983c3a5727df9ab4f565f5f4a&language=en-US&page=1")))
//           .thenAnswer(
//         (_) async => http.Response(
//           response,
//           200,
//           headers: {'content-type': 'application/json; charset=utf-8'},
//         ),
//       );
//       expect(await movieRemote.fetchNowPlayingMovies(), isA<MovieEntity>());
//     });
//
//     test(
//         "throws an exception if fetching Now Playing movies completes with an error",
//         () async {
//           when(client.get(any))
//           .thenAnswer((_) async => http.Response('Not Found', 404));
//       expect(movieRemote.fetchNowPlayingMovies(), throwsException);
//     });
//
//     test(
//         "returns a PopularMovie response if the http call completes successfully",
//         () async {
//       final response = await jsonParser
//           .getMockJsonFile("test/api_response/popular_movie_response.json");
//
//       when(client.get(any)).thenAnswer(
//         (_) async => http.Response(
//           response,
//           200,
//           headers: {'content-type': 'application/json; charset=utf-8'},
//         ),
//       );
//
//       expect(await movieRemote.fetchPopularMovies(), isA<MovieEntity>());
//     });
//   });
// }
