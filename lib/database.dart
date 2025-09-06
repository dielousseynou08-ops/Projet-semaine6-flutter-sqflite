import 'package:myquicknotes/modele/users.dart';
import 'package:myquicknotes/modele/note_modele.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDb {
  final databaseName = "mydb.db";

  String tableName = "users";

  String tableNote = "notes";

  //login
  Future<bool> login(Users user) async {
    final db = await initDB();
    var result = await db.rawQuery(
      "SELECT * FROM users WHERE usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}'",
    );
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //sign up
  Future<int> signup(Users user) async {
    final db = await initDB();
    return db.insert("users", user.toMap());
  }

  Future<Database> initDB() async {
    //  await deleteDatabase(join(await getDatabasesPath(), "mydb.db"));
    final databasePath = await getDatabasesPath();

    final Path = join(databasePath, databaseName);
    return openDatabase(
      Path,
      version: 1,
      onCreate: (db, version) async {
        // table users
        await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      usrName TEXT NOT NULL,
      usrPassword TEXT NOT NULL
    )
  ''');

        // table notes
        await db.execute('''
    CREATE TABLE notes(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      createdAt TEXT NOT NULL
    )
  ''');
      },
    );
  }

  //pour la barre de recherche

  Future<List<Notes>> searchNote(String keyword) async {
    final db = await initDB();
    List<Map<String, Object?>> searchResult = await db.rawQuery(
      "select * from notes  where noteTitle LIKE ?",
      ["%$keyword%"],
    );
    return searchResult.map((e) => Notes.fromMap(e)).toList();
  }

  //insert

  Future<int> createNote(Notes note) async {
    final db = await initDB();
    return await db.insert(
      "notes",
      note.toMap(),

      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Notes>> getNotes() async {
    final db = await initDB();
    List<Map<String, Object?>> result = await db.query("notes");
    return result.map((e) => Notes.fromMap(e)).toList();
  }

  Future<int> deleteNote(int noteId) async {
    final db = await initDB();
    return await db.delete(tableNote, where: "noteId = ?", whereArgs: [noteId]);
  }

  Future<int> updateNote(title, content, noteId) async {
    final db = await initDB();
    return await db.update(
      'notes',
      {'noteTitle': title, 'noteContent': content},
      where: 'noteId = ?',
      whereArgs: [noteId],
    );
  }
}
