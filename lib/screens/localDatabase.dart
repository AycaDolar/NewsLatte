import 'package:newsLatte/helper/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class NewsDatabase {
  static final NewsDatabase instance = NewsDatabase._init();

  static Database? _database;

  NewsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableNewsTile(
  ${NewsTileFields.id} $idType,  
  ${NewsTileFields.imgUrl} $textType, 
  ${NewsTileFields.desc} $textType,
  ${NewsTileFields.title} $textType,
  ${NewsTileFields.content} $textType,
  ${NewsTileFields.publishedAt} $textType,
  ${NewsTileFields.category} $textType
  )
''');
  }

  Future<NewsTile> create(NewsTile newsTile) async {
    final db = await instance.database;

    final id = await db.insert(tableNewsTile, newsTile.toJson());
    return newsTile.copy(id: id);
  }
  Future<List<NewsTile>> readAllNotes() async {
    final db = await instance.database;

    // const orderBy = '${NewsTileFields.publishedAt} ASC';
    //
     final result = await db.query(tableNewsTile);

    return result.map((json) => NewsTile.fromJson(json)).toList();
  }
  Future<int> update(NewsTile newsTile) async {
    final db = await instance.database;

    return db.update(
      tableNewsTile,
      newsTile.toJson(),
      where: '${NewsTileFields.id} = ?',
      whereArgs: [newsTile.id],
    );
  }
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNewsTile,
      where: '${NewsTileFields.id} = ?',
      whereArgs: [id],
    );


  }
  Future close() async {
    final db = await instance.database;
    _database = null;
    return db.close();
  }}