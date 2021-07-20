import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:take_a_note/models/note_model.dart';

class DatabaseService {
  static const DatabaseService instance = DatabaseService._();

  const DatabaseService._();

  static const String _notesTable = 'notes_table';
  static const String _colId = 'id';
  static const String _colTitulo = 'titulo';
  static const String _colContenido = 'contenido';
  static const String _colCategoria = 'categoria';

  static Database? _db;

  Future<Database> get db async {
    _db ??= await _openDb();
    return _db!;
  }

  Future<Database> _openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path + '/note_list.db';
    final noteListDb = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE $_notesTable (
          $_colId INTEGER PRIMARY KEY AUTOINCREMENT,
          $_colTitulo TEXT,
          $_colContenido TEXT,
          $_colCategoria TEXT
        )
      ''');
    });
    return noteListDb;
  }

  Future<Note> insert(Note note) async {
    final db = await this.db;
    final id = await db.insert(_notesTable, note.toMap());

    final noteWithId = note.copyWith(id: id);
    return noteWithId;
  }

  Future<List<Note>> getAllNotes() async {
    final db = await this.db;
    final notesData = await db.query(_notesTable, orderBy: '$_colId DESC');

    return notesData.map((e) => Note.fromMap(e)).toList();
  }

  Future<List<Note>> getFilterNotes({String? filtro}) async {
    final db = await this.db;
    final notesData = await db.query(_notesTable,
        where: '$_colCategoria = ?',
        whereArgs: [filtro],
        orderBy: '$_colId DESC');

    return notesData.map((e) => Note.fromMap(e)).toList();
  }

  Future<int> update(Note note) async {
    final db = await this.db;
    return await db.update(
      _notesTable,
      note.toMap(),
      where: '$_colId = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await this.db;
    return await db.delete(
      _notesTable,
      where: '$_colId = ?',
      whereArgs: [id],
    );
  }
}
