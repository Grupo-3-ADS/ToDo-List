import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String taskTable = "Tarefa";
const String idColumn = "Id";
const String nameColumn = "Nome";
const String dateColumn = "Data";
const String timeColumn = "Hora";
const String userIdColumn = "UserId";

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider.internal();

  factory DatabaseProvider() => _instance;

  DatabaseProvider.internal();
  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "Tarefa.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $taskTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $dateColumn TEXT,"
          "$timeColumn TEXT, $userIdColumn INTEGER)");
    });
  }

  Future<Task> saveTask(Task task) async {
    Database? dbTask = await db;
    task.id = await dbTask.insert(taskTable, task.toMap());
    return task;
  }

  Future<Task?> getTask(int id) async {
    Database? dbTask = await db;
    List<Map> maps = await dbTask.query(taskTable,
        columns: [idColumn, nameColumn, dateColumn, timeColumn, userIdColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Task.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteTask(int id) async {
    Database? dbTask = await db;
    return await dbTask
        .delete(taskTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateTask(Task task) async {
    Database dbTask = await db;
    return await dbTask.update(taskTable, task.toMap(),
        where: "$idColumn = ?", whereArgs: [task.id]);
  }

  Future<List> getAllTasks(int? userId) async {
    Database? dbTask = await db;
    List listMap = await dbTask
        .rawQuery("SELECT * FROM $taskTable WHERE UserId = $userId");
    List<Task> listTask = [];
    print("Chargou aqui");
    for (Map m in listMap) {
      listTask.add(Task.fromMap(m));
    }
    return listTask;
  }
}

class Task {
  int? id;
  String? name;
  String? date;
  String? time;
  int? userId;

  Task(this.id, this.name, this.date, this.time, this.userId);

  Task.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    date = map[dateColumn];
    time = map[timeColumn];
    userId = map[userIdColumn];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      dateColumn: date,
      timeColumn: time,
      userIdColumn: userId
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }
}
