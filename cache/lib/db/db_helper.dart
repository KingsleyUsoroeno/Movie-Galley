import 'dart:io';

import 'package:cache/models/cache_movie_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/cache_now_playing_movies.dart';
import '../models/cache_popular_movie.dart';

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
    String sqlCreateMovieTable = 'CREATE TABLE $movies('
        '$_columnId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$_columnPage INTEGER,'
        '$_columnTotalResults INTEGER,'
        '$_columnTotalPages INTEGER,'
        '$_columnMovieResults TEXT'
        ')';

    String sqlCreateNowPlayingMoviesTable = 'CREATE TABLE $nowPlaying('
        '$_columnId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$_columnPage INTEGER,'
        '$_columnTotalResults INTEGER,'
        '$_columnTotalPages INTEGER,'
        'dates TEXT,'
        '$_columnMovieResults TEXT'
        ')';

    String sqlCreatePopularMoviesTable = 'CREATE TABLE $popularMovies('
        '$_columnId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$_columnPage INTEGER,'
        '$_columnTotalResults INTEGER,'
        '$_columnTotalPages INTEGER,'
        '$_columnMovieResults TEXT'
        ')';
    db.execute(sqlCreateMovieTable);
    db.execute(sqlCreateNowPlayingMoviesTable);
    db.execute(sqlCreatePopularMoviesTable);
  }

  Future<int> saveMovie(CacheMovieModel movie) async {
    await deleteAllMovies();
    final db = await database;
    return await db.insert(movies, movie.toJson());
  }

  Future<int> saveNowPlaying(CacheNowPlayingMovie movie) async {
    await deleteAllNowPlaying();
    final db = await database;
    return await db.insert(nowPlaying, movie.toJson());
  }

  Future<int> savePopularMovies(CachePopularMovie cachePopularMovie) async {
    await deleteAllPopularMovies();
    final db = await database;
    return await db.insert(popularMovies, cachePopularMovie.toJson());
  }

  Future<int> updateMovie(CacheMovieModel movieDatabaseModel) async {
    final db = await database;
    return db.update(movies, movieDatabaseModel.toJson(),
        where: 'id = ?',
        whereArgs: [movieDatabaseModel.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateNowPlaying(CacheNowPlayingMovie nowPlayingMovie) async {
    final db = await database;
    return db.update(nowPlaying, nowPlayingMovie.toJson(),
        where: 'id = ?',
        whereArgs: [nowPlayingMovie.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updatePopularMovies(CachePopularMovie popularMovie) async {
    final db = await database;
    return db.update(popularMovies, popularMovie.toJson(),
        where: 'id = ?',
        whereArgs: [popularMovie.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future deleteAllMovies() async {
    final db = await database;
    return await db.rawDelete('DELETE FROM $movies');
  }

  Future deleteAllNowPlaying() async {
    final db = await database;
    return await db.rawDelete('DELETE FROM $nowPlaying');
  }

  Future deleteAllPopularMovies() async {
    final db = await database;
    return await db.rawDelete('DELETE FROM $popularMovies');
  }

  Future<List<CacheMovieModel>> getAllMovies() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(movies);
    print(maps);
    return List.generate(maps.length, (i) {
      return CacheMovieModel(
          id: maps[i]['id'],
          page: maps[i]['page'],
          totalResults: maps[i]['totalResults'],
          totalPages: maps[i]["totalPages"],
          results: movieResultsFromJson(maps[i]["movieResults"]));
    });
  }

  Future<List<CacheNowPlayingMovie>> getAllNowPlaying() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(nowPlaying);
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return CacheNowPlayingMovie(
        id: maps[i]['id'],
        page: maps[i]['page'],
        totalResults: maps[i]['totalResults'],
        totalPages: maps[i]["totalPages"],
        results: movieResultsFromJson(maps[i]["movieResults"]),
      );
    });
  }

  Future<List<CachePopularMovie>> getAllPopularMovies() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(popularMovies);
    return List.generate(maps.length, (i) {
      return CachePopularMovie(
          id: maps[i]['id'],
          page: maps[i]['page'],
          totalResults: maps[i]['totalResults'],
          totalPages: maps[i]["totalPages"],
          results: movieResultsFromJson(maps[i]["movieResults"]));
    });
  }
}
