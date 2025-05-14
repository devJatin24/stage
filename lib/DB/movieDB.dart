import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/movie.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'StageAssesmentDB.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute(SqlTable.MovieDataTable);
  }

  Future<bool> insertMovie(MovieModel movie) async {
    try {
      final db = await database;
      await db.insert('MovieData', {
        "id": movie.movieId,
        "favorite": movie.favorite == true ? 1 : 0,
        "title": movie.title,
        "posterPath": movie.posterPath,
        "backdropPath": movie.backdropPath,
      });
      debugPrint("Data Save Local");
      return true;
    } catch (e) {
      debugPrint("data not saved error $e");
      return false;
    }
  }

  Future<List<MovieModel>> getAllMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('MovieData');

    return List.generate(maps.length, (i) {
      return MovieModel(
        // localId: maps[i]['localId'],
        favorite: maps[i]['favorite'] == 1,
        backdropPath: maps[i]['backdropPath'],
        movieId: maps[i]['id'],
        originalLanguage: maps[i]['originalLanguage'],
        originalTitle: maps[i]['originalTitle'],
        posterPath: maps[i]['posterPath'],
        title: maps[i]['title'],
      );
    });
  }

  Future<bool> deleteMovie(int movieId) async {
    try {
      final db = await database;

      //  check if movie exists
      final existingMovies = await db.query(
        'MovieData',
        where: 'id = ?',
        whereArgs: [movieId],
        limit: 1,
      );

      if (existingMovies.isEmpty) {
        debugPrint("No movie found in DB");
        return false;
      }


      final deletedCount = await db.delete(
        'MovieData',
        where: 'id = ?',
        whereArgs: [movieId],
      );

      debugPrint("Successfully deleted ");
      return deletedCount > 0;

    } catch (e) {
      debugPrint("Error in deleteMovie: $e");
      return false;
    }
  }

  Future<bool> deleteAllMovies() async {
    try {
      final db = await database;
      final deletedCount = await db.delete('MovieData');

      return deletedCount > 0;
    } catch (e) {
      debugPrint("Error in deleteAllMovies: $e");
      return false;
    }
  }
}

class SqlTable {
  static String MovieDataTable = '''
      CREATE TABLE MovieData(
        databaseId INTEGER PRIMARY KEY AUTOINCREMENT,
        id INTEGER,
        favorite INTEGER,
        posterPath TEXT,
        title TEXT,
        backdropPath TEXT
      )
    ''';
}
