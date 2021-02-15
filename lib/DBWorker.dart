import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DBWorker {
  DBWorker._();
  static final DBWorker db = new DBWorker._();
  static Database _database;
  Future<Database> get database async{
    if(_database == null){
      _database = await _initDB();
    }
    return _database;
  }
 Future<Database> _initDB() async {
    print('DBWWorker::_initDB()');
    String databasePath = await getDatabasesPath();
    String databaseFilePath = join(databasePath, 'data.db');
    return await openDatabase(databaseFilePath, version: 1,
      onOpen: (Database inDB){print('DB managed to open!');},
      onCreate: (Database inDB, int version) async {
        print('DB is open successfully, not time to insert some data!');
        _setUpMorningMessagesTable(inDB);
        _setUpNoonMessagesTable(inDB);
        _setUpAfternoonMessagesTable(inDB);
        _setUpEveningMessagesTable(inDB);
        _setUpLateNightMessagesTable(inDB);
      }
    );
  }
  _setUpMorningMessagesTable(Database db) async {
    print("DBWorker::setUpMorningMessages()");
    await db.transaction((txn) async {
      txn.execute(
          "CREATE TABLE IF NOT EXISTS morningMessages ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "title TEXT,"
              "body TEXT"
              ");"
      );
    });
    _insertMorningMessages(db);
  }
  _insertMorningMessages(Database db) async {
    await db.transaction((txn) async {
      txn.rawInsert('INSERT INTO morningMessages (title, body) VALUES (?, ?)',
          ['Good Morning ', 'Such a beautiful day! Do not forget to have a nice breakfast.']
      );
    });
  }
  _setUpNoonMessagesTable(Database db) async {
    print("DBWorker::setUpNoonMessagesTable()");
    await db.transaction((txn) async {
      txn.execute("CREATE TABLE IF NOT EXISTS noonMessages ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "title TEXT,"
          "body TEXT"
          ");"
      );
    });
    _insertNoonMessages(db);
  }
  _insertNoonMessages(Database db) async {
    await db.transaction((txn) async {
      txn.rawInsert('INSERT INTO noonMessages (title, body) VALUES (?, ?)',
          ['Hello there!',
            'Still have a long day ahead? What about having a small break getting some fresh air?']
      );
    });
  }
  _setUpAfternoonMessagesTable(Database db) async {
    print("DBWorker::setUpAfternoonMessagesTable()");
    await db.transaction((txn) async {
      txn.execute('CREATE TABLE IF NOT EXISTS afternoonMessages ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'title TEXT,'
          'body TEXT'
          ');'
      );
    });
    _insertAfternoonMessages(db);
  }
  _insertAfternoonMessages(Database db) async{
    await db.transaction((txn) async {
      txn.rawInsert('INSERT INTO afternoonMessages (title, body) VALUES (?, ?), (?, ?)',
        ['Good Afternoon ', 'Maybe it is a good time to check your email!',
          'Hello there! ', 'Your body will thank you for a 15-30 minutes nap :)'],
      );
    });
  }
  _setUpEveningMessagesTable(Database db ) async {
    print("DBWorker::setUpEveningMessagesTable()");
    await db.transaction((txn) async {
      txn.execute('CREATE TABLE IF NOT EXISTS eveningMessages ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'title TEXT,'
          'body TEXT'
          ');');
    });
    _insertEveningMessages(db);
  }
  _insertEveningMessages(Database db) async {
    db.transaction((txn) async {
      txn.rawInsert('INSERT INTO eveningMessages (title, body) VALUES (?, ?)',
          ['Good Evening ', 'A family dinner is an absolutely awesome idea :)']
      );
    });
  }
  _setUpLateNightMessagesTable(Database db) async {
    print("DBWorker::setUpLateNightMessagesTable()");
    await db.transaction((txn) async {
      txn.execute('CREATE TABLE IF NOT EXISTS lateNightMessages ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'title TEXT,'
          'body TEXT'
          ');');
    });
    _insertLateEveningMessages(db);
  }
  _insertLateEveningMessages(Database db) async {
    db.transaction((txn) async {
      txn.rawInsert('INSERT INTO lateNightMessages (title, body) VALUES (?, ?), (?, ?)',
          ['Good night ', 'You deserve 7-8 hours of uninterrupted sleep :)',
            'Good night ', 'Maybe you would like to turn off Wifi before going to bed!']
      );
    });
  }

  Future<Messages> getMorningMessage() async {
    print("DBWorker::getMorningMessage()");
    final db = await database;
    var map = await db.query("morningMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Future<Messages> getNoonMessage() async {
    print("DBWorker::getNoonMessage()");
    final db = await database;
    var map = await db.query("noonMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Future<Messages> getAfternoonMessage() async {
    print("DBWorker::getNoonMessage()");
    final db = await database;
    var map = await db.query("afterNoonMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Future<Messages> getEveningMessage() async {
    print("DBWorker::getEveningMessage()");
    final db = await database;
    var map = await db.query("eveningMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Future<Messages> getLateNightMessage() async {
    print("DBWorker::getNoonMessage()");
    final db = await database;
    var map = await db.query("lateNightMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Messages messageFromMap(dynamic inMap){
    Messages msg = Messages();
    msg.title = inMap["title"];
    msg.body = inMap["body"];
    return msg;
  }
}
class Messages{
  String title;
  String body;
}