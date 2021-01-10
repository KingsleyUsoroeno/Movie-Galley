import 'dart:convert';

import 'package:http/http.dart' as http;

class Post {
  dynamic data;

  Post.fromJson(this.data);
}

Future<Post> fetchPost(http.Client client) async {
  final response = await client.get('https://jsonplaceholder.typicode.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(jsonDecode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
