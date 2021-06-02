import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../core/app_const.dart';
import '../models/stuff_model.dart';
import 'stuff_repository.dart';

class StuffRepositoryImpl implements StuffRepository {
  static const vTableName = 'stuff';
  static const vCreateTableSql =
      'CREATE TABLE $vTableName(id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT, contactName TEXT, date TEXT, photoPath TEXT, phone TEXT);';

  Future<Database> _getDatabase() async {
    final path = join(await getDatabasesPath(), gDatabaseName);
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(vCreateTableSql);
      },
      version: gDatabaseVersion,
    );
  }

  @override
  Future create(StuffModel stuff) async {
    Database db;
    try {
      db = await _getDatabase();
      await db.insert(
        vTableName,
        stuff.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      print(error);
    } finally {
      db.close();
    }
  }

  @override
  Future delete(StuffModel stuff) async {
    Database db;
    try {
      db = await _getDatabase();
      await db.delete(
        vTableName,
        where: 'id = ?',
        whereArgs: [stuff.id],
      );
    } catch (error) {
      print(error);
    } finally {
      db.close();
    }
  }

  @override
  Future update(StuffModel stuff) async {
    Database db;
    try {
      db = await _getDatabase();
      await db.update(
        vTableName,
        stuff.toMap(),
        where: 'id = ?',
        whereArgs: [stuff.id],
      );
    } catch (error) {
      print(error);
    } finally {
      db.close();
    }
  }

  @override
  Future<List<StuffModel>> readAll() async {
    Database db;
    try {
      db = await _getDatabase();
      final data = await db.query(vTableName);
      return List.generate(
        data.length,
        (index) => StuffModel.fromMap(data[index]),
      );
    } catch (error) {
      print(error);
      return <StuffModel>[];
    } finally {
      db.close();
    }
  }

  @override
  Future<StuffModel> readById(int id) async {
    Database db;
    try {
      db = await _getDatabase();
      final data = await db.query(
        vTableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      return StuffModel.fromMap(data[0]);
    } catch (error) {
      print(error);
      return null;
    } finally {
      db.close();
    }
  }
}
