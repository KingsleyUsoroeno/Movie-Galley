import 'dart:io';

import 'package:movies/data/model/database/db/database_wrapper.dart';
import 'package:movies/data/model/database/model/movie_model.dart';
import 'package:movies/data/model/database/model/now_playing_model.dart';
import 'package:movies/data/model/database/model/popular_movie_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider extends DatabaseWrapper {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  // TABLE NAMES
  final String movies = "movies";
  final String nowPlaying = "nowPlaying";
  final String popularMovies = "popularMovies";

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

    return await openDatabase(path, onCreate: (db, version) => _createDb(db), version: 1);
  }

  void _createDb(Database db) {
    String sqlCreateMovieTable = 'CREATE TABLE $movies('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'page INTEGER,'
        'totalResults INTEGER,'
        'totalPages INTEGER,'
        'movieResults TEXT'
        ')';

    String sqlCreateNowPlayingMoviesTable = 'CREATE TABLE $nowPlaying('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'page INTEGER,'
        'totalResults INTEGER,'
        'totalPages INTEGER,'
        'dates TEXT,'
        'movieResults TEXT'
        ')';

    String sqlCreatePopularMoviesTable = 'CREATE TABLE $popularMovies('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'page INTEGER,'
        'totalResults INTEGER,'
        'totalPages INTEGER,'
        'movieResults TEXT'
        ')';
    db.execute(sqlCreateMovieTable);
    db.execute(sqlCreateNowPlayingMoviesTable);
    db.execute(sqlCreatePopularMoviesTable);
  }

  @override
  Future<int> saveMovie(MovieDatabaseModel movie) async {
    await deleteAllMovies();
    final db = await database;
    print("Movie to save is ${movie.toString()}");
    return await db.insert(movies, movie.toJson());
  }

  @override
  Future<int> saveNowPlaying(NowPlayingDatabaseModel nowPlayingDatabaseModel) async {
    await deleteAllNowPlaying();
    final db = await database;
    print("Now playing movie to save to db is ${nowPlayingDatabaseModel.toString()}");
    return await db.insert(nowPlaying, nowPlayingDatabaseModel.toJson());
  }

  @override
  Future<int> savePopularMovies(PopularMoviesDatabaseModel popularMoviesDatabaseModel) async {
    await deleteAllPopularMovies();
    final db = await database;
    print("popular movies to save is ${popularMoviesDatabaseModel.toString()}");
    return await db.insert(popularMovies, popularMoviesDatabaseModel.toJson());
  }

  @override
  Future<int> updateMovie(MovieDatabaseModel movieDatabaseModel) async {
    final db = await database;
    return db.update(movies, movieDatabaseModel.toJson(),
        where: 'id = ?', whereArgs: [movieDatabaseModel.id], conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<int> updateNowPlaying(NowPlayingDatabaseModel nowPlayingDatabaseModel) async {
    final db = await database;
    return db.update(nowPlaying, nowPlayingDatabaseModel.toJson(),
        where: 'id = ?', whereArgs: [nowPlayingDatabaseModel.id], conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<int> updatePopularMovies(PopularMoviesDatabaseModel popularMoviesDatabaseModel) async {
    final db = await database;
    return db.update(popularMovies, popularMoviesDatabaseModel.toJson(),
        where: 'id = ?', whereArgs: [popularMoviesDatabaseModel.id], conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future deleteAllMovies() async {
    final db = await database;
    return await db.rawDelete('DELETE FROM $movies');
  }

  @override
  Future deleteAllNowPlaying() async {
    final db = await database;
    return await db.rawDelete('DELETE FROM $nowPlaying');
  }

  @override
  Future deleteAllPopularMovies() async {
    final db = await database;
    return await db.rawDelete('DELETE FROM $popularMovies');
  }

  @override
  Future<List<MovieDatabaseModel>> getAllMovies() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(movies);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return MovieDatabaseModel(
          id: maps[i]['id'],
          page: maps[i]['page'],
          totalResults: maps[i]['totalResults'],
          totalPages: maps[i]["totalPages"],
          results: movieResultsFromJson(maps[i]["movieResults"]));
    });
  }

  @override
  Future<List<NowPlayingDatabaseModel>> getAllNowPlaying() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(nowPlaying);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return NowPlayingDatabaseModel(
          id: maps[i]['id'],
          totalResults: maps[i]['totalResults'],
          totalPages: maps[i]["totalPages"],
          results: movieResultsFromJson(maps[i]["movieResults"]));
    });
  }

  @override
  Future<List<PopularMoviesDatabaseModel>> getAllPopularMovies() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(popularMovies);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return PopularMoviesDatabaseModel(
          id: maps[i]['id'],
          page: maps[i]['page'],
          totalResults: maps[i]['totalResults'],
          totalPages: maps[i]["totalPages"],
          results: movieResultsFromJson(maps[i]["movieResults"]));
    });
  }
}
