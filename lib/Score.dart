// import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class Score{
  final int id;
  final String date;
  final int grade;
  final int try_num;
  final int correct_num;

  Score({
    this.id,
    this.date,
    this.grade,
    this.try_num,
    this.correct_num
    }
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'grade': grade,
      'try_num': try_num,
      'correct_num':correct_num
    };
  }

  @override
  String toString() {
    return 'Score{id: $id, date:$date, grade: $grade, try_num: $try_num, correct_num: $correct_num}';
  }


  static Future<Database> get database async {
    final Future<Database> _database = openDatabase(
      join(await getDatabasesPath(), 'Score.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE Score(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, grade INTEGER, try_num INTEGER, correct_num INTEGER)",
        );
      },
      version: 1,
    );
    return _database;
  }

  static Future<void> insertScore(Score score) async {
    final Database db = await database;
    await db.insert(
      'Score',
      score.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }



  static Future<List<Score>> getScores() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Score');
    return List.generate(maps.length, (i) {
      return Score(
        id: maps[i]['id'],
        date: maps[i]['date'],
        grade: maps[i]['grade'],
        try_num: maps[i]['try_num'],
        correct_num: maps[i]['correct_num'],
      );
    });
  }

  static Future<void> updateScore(Score score) async {
    final db = await database;
    await db.update(
      'Score',
      score.toMap(),
      where: "id = ?",
      whereArgs: [score.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  static Future<void> deleteScore(int id) async {
    final db = await database;
    await db.delete(
      'Score',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}