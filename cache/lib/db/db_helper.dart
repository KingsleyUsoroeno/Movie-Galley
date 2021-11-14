import 'dart:io';

import 'package:cache/models/movie_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _database;
  static final DatabaseHelper db = DatabaseHelper._();

  DatabaseHelper._();

  // TABLE NAMES
  final String movies = "movies";
  final String nowPlaying = "nowPlaying";
  final String popularMovies = "popularMovies";

  // COLUMN NAMES
  final String _columnId = "id";
  final String _columnPage = "page";
  final String _columnTotalResults = "totalResults";
  final String _columnTotalPages = "totalPages";
  final String _columnMovieResults = "movieResults";

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Necessary tables
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'movies.db');

    return await openDatabase(path,
        onCreate: (db, version) => _createDb(db), version: 1);
  }

  void _createDb(Database db) {
    db.execute(createTableQuery(movies));
    db.execute(createTableQuery(nowPlaying));
    db.execute(createTableQuery(popularMovies));
  }

  String createTableQuery(String tableName) {
    return 'CREATE TABLE $tableName('
        '$_columnId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$_columnPage INTEGER,'
        '$_columnTotalResults INTEGER,'
        '$_columnTotalPages INTEGER,'
        '$_columnMovieResults TEXT'
        ')';
  }

  Future<int> saveMovie(MovieModel movie) async {
    await deleteAllMovies(movies);
    return _cacheMovie(movies, movie);
  }

  Future<int> saveNowPlaying(MovieModel movie) async {
    await deleteAllMovies(nowPlaying);
    return _cacheMovie(nowPlaying, movie);
  }

  Future<int> savePopularMovies(MovieModel movie) async {
    await deleteAllMovies(popularMovies);
    return _cacheMovie(popularMovies, movie);
  }

  Future<int> _cacheMovie(String tableName, MovieModel movie) async {
    await deleteAllMovies(tableName);
    final db = await database;
    return await db.insert(tableName, movie.toJson());
  }

  Future<int> updateMovie(MovieModel cacheMovie) async {
    return await _updateMovie(movies, cacheMovie);
  }

  Future<int> updateNowPlaying(MovieModel movie) async {
    return await _updateMovie(nowPlaying, movie);
  }

  Future<int> updatePopularMovies(MovieModel popularMovie) async {
    return await _updateMovie(popularMovies, popularMovie);
  }

  Future<int> _updateMovie(String tableName, MovieModel movie) async {
    final db = await database;
    return db.update(
      tableName,
      movie.toJson(),
      where: 'id = ?',
      whereArgs: [movie.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future deleteAllMovies(String tableName) async {
    final db = await database;
    return await db.rawDelete('DELETE FROM $tableName');
  }

  Future<List<MovieModel>> _getCachedMovies(String tableName) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return MovieModel(
          id: maps[i]['id'],
          page: maps[i]['page'],
          totalResults: maps[i]['totalResults'],
          totalPages: maps[i]["totalPages"],
          results: movieResultsFromJson(maps[i]["movieResults"]));
    });
  }

  Future<List<MovieModel>> getAllMovies() async {
    return await _getCachedMovies(movies);
  }

  Future<List<MovieModel>> getAllNowPlaying() async {
    return await _getCachedMovies(nowPlaying);
  }

  Future<List<MovieModel>> getAllPopularMovies() async {
    return await _getCachedMovies(popularMovies);
  }
}
