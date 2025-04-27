import 'dart:developer';

import 'package:build_smart/features/dashboard/model/chat_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class ChatDatabase {
  static final ChatDatabase instance = ChatDatabase._init();
  static Database? _database;

  ChatDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('chat_sessions.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE sessions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      session_data TEXT
    )
    ''');
  }

  Future<void> saveSession(List<ChatModel?> sessionMessages) async {
    if (sessionMessages.isEmpty) {
      return;
    }
    final db = await instance.database;

    log(sessionMessages.length.toString(), name: 'session message length');
    for (var e in sessionMessages) {
      log(e?.text ?? ''.toString());
    }

    final sessionJson = jsonEncode(
      sessionMessages.map((e) => e?.toMap()).toList(),
    );

    await db.insert(
      'sessions',
      {'session_data': sessionJson},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<List<ChatModel>>> fetchSessions() async {
    final db = await instance.database;

    final result = await db.query('sessions');

    return result.map((row) {
      final sessionData = row['session_data'] as String;
      final decodedList = jsonDecode(sessionData) as List<dynamic>;

      return decodedList.map((item) {
        return ChatModel.fromMap(Map<String, dynamic>.from(item));
      }).toList();
    }).toList();
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
    _database = null;
  }
}
