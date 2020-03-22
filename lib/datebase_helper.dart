import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import './note.dart';
import 'package:path_provider/path_provider.dart';

class DatebaseHelper {
  static DatebaseHelper _databasehelper; //singletone databse helper
  static Database _database; // singleton databse

  String notetable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priorirty';
  String colDate = 'date';

  DatebaseHelper._createInstance(); // names constructor to create instance of datebase helper

  factory DatebaseHelper() {
    if (_databasehelper == null) {
      _databasehelper = DatebaseHelper._createInstance();
    }

    return _databasehelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatbase();
    }
    return _database;
  }

  Future<Database> initializeDatbase() async {
//get the directory path  store databse

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

//open or create databse t a given path
    var noteDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return noteDatabase;
  }

  void _createDb(Database db, int newversion) async {
    await db.execute(
        'CREATE TABLE $notetable($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$colTitle TEXT, $colDescription TEXT, $colDate TEXT, $colPriority INTEGER)');
  }

//Fetch operation : get all not object from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

    // var result = await db.rawQuery('SELECT * FROM $notetable order by $colPriority ASC');
    var result = await db.query(notetable, orderBy: '$colPriority ASC');
    return result;
  }

//insert operation
  Future<int> insertNote(Note note) async {
    Database db = await this.database;

    var result = await db.insert(notetable, note.toMap());

    return result;
  }

//update operation

  Future<int> updateNote(Note note) async {
    Database db = await this.database;

    var result = await db.update(notetable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);

    return result;
  }

//delete operation

  Future<int> deleteeNote(int id) async {
    Database db = await this.database;

    var result =
        await db.rawDelete('DELETE FROM $notetable WHERE $colId = $id');

    return result;
  }

//get no og not object  in databse
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $notetable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

//get map list from bd convert into  map list

  Future<List<Note>> getNoteList() async {
    var notemaplist = await getNoteMapList();
    int count = notemaplist.length;

    List<Note> notelist = List<Note>();

    for (int i = 0; i < count; i++) {
      notelist.add(Note.fromMapObject(notemaplist[i]));
    }
    return notelist;
  }
}
