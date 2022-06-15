import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/Word.dart';

class DatabaseHelper {
  Database? _database;

  DatabaseHelper() {
    database;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath =
        await getDatabasesPath(); // Returns relative path of DB directory/Document directory
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textTypeUnique = 'TEXT NOT NULL UNIQUE';

    await db.execute(
        'CREATE TABLE $tableWord (${WordFields.id} $idType, ${WordFields.word} $textTypeUnique, ${WordFields.meaning} $textType)');
  }

  Future<Word> create(Word word) async {
    print("Creating DB");
    final db = await database;
    try {
      final id = await db.insert(tableWord, word.toJson());
      return word.copy(id: id);
    } catch (e) {
      throw Exception("Failed");
    }
  }

  Future<Word> readWord(int id) async {
    final db = await database;
    final maps = await db.query(tableWord,
        columns: WordFields.values,
        where: ' ${WordFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Word.fromJson(maps.first);
    } else {
      throw Exception("ID ${id} not found");
    }
  }

  Future<List<Word>> readAllWords() async {
    const orderBy = '${WordFields.id} ASC';
    final db = await database;
    final results = await db.query(tableWord, orderBy: orderBy);
    if (results.isEmpty) return [];
    return results.map((json) => Word.fromJson(json)).toList();
  }

  Future<int> update(Word word) async {
    final db = await database;
    final result = db.update(tableWord, word.toJson(),
        where: '${WordFields.id}', whereArgs: [word.id]);
    return result;
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
