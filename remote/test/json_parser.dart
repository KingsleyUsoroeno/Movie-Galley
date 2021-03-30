import 'dart:io';

class JsonParser {
  Future<File> getProjectFile(String path) async {
    var dir = Directory.current;
    while (!await dir
        .list()
        .any((entity) => entity.path.endsWith('pubspec.yaml'))) {
      dir = dir.parent;
    }
    return File('${dir.path}/$path');
  }

  Future<String> getMockJsonFile(String path) async {
    final response = await getProjectFile(
        "test/api_response/now_playing_movie_response.json");
    return await response.readAsString();
  }
}
