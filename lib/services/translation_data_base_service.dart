import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:strong_translate/models/translation.dart';

class TranslationDataBase extends ChangeNotifier {
  TranslationDataBase.internal();

  static final TranslationDataBase _instance = TranslationDataBase.internal();

  factory TranslationDataBase() => _instance;

  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, 'translation.db');
    notifyListeners();
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int newVersion) async {
        await db.execute(
          'CREATE TABLE $translationTable($idColumn INTEGER PRIMARY KEY, $sourceTextColumn TEXT, $translatedTextColumn TEXT,$sourceLangColumn TEXT, $targetLangColumn TEXT)',
        );
      },
    );
  }

  //Salvar as traduções
  Future<Translation> saveTranslation(Translation translation) async {
    final dbTranslation = await db;
    final insertedId = await dbTranslation?.insert(
      translationTable,
      translation.toMap(),
    );
    notifyListeners();
    return translation.copyWith(id: insertedId);
  }

  //Obter os dados de uma tradução
  Future<Translation?> getTranslation(int id) async {
    final dbTranslation = await db;
    final maps = await dbTranslation?.query(
      translationTable,
      columns: [
        idColumn,
        sourceTextColumn,
        translatedTextColumn,
        sourceLangColumn,
        targetLangColumn,
      ],
      where: '$idColumn = ?',
      whereArgs: [id],
    );
    notifyListeners();
    if (maps?.isNotEmpty ?? false) {
      return Translation.fromMap(maps!.first);
    } else {
      return null;
    }
  }

  //Deletar tradução
  Future<int> deleteTranslation(int id) async {
    final dbTranslation = await db;
    if (dbTranslation == null) {
      throw Exception('Base de Dados não inicializada');
    }
    notifyListeners();
    return await dbTranslation.delete(
      translationTable,
      where: '$idColumn = ?',
      whereArgs: [id],
    );
  }

  //Atualizar Tradução
  Future<int> updateTranslation(Translation translation) async {
    final dbTranslation = await db;
    notifyListeners();
    if (dbTranslation == null) {
      throw Exception('Base de dados não inicializada');
    }
    if (translation.id == null) {
      throw ArgumentError(
        'Id da tradução não pode ser nula para ser atualizada',
      );
    }

    return await dbTranslation.update(
      translationTable,
      translation.toMap(),
      where: '$idColumn = ?',
      whereArgs: [translation.id],
    );
  }

  //Obter todas as traduções
  Future<List<Translation>> getAllTranslations() async {
    final dbTranslation = await db;
    if (dbTranslation == null) {
      throw Exception('Base de dados não inicializada');
    }

    List<Map<String, dynamic>> listMap = await dbTranslation.rawQuery(
      'SELECT * FROM $translationTable',
    );
    List<Translation> listTranslation = [];
    for (Map<String, dynamic> m in listMap) {
      listTranslation.add(Translation.fromMap(m));
    }
    notifyListeners();
    return listTranslation;
  }

  Future<void> close() async {
    final dbTranslation = await db;
    if (dbTranslation != null) await dbTranslation.close();
    notifyListeners();
  }
}
