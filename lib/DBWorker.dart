import 'dart:io';
import 'package:sqflite/sqflite.dart';
import "package:path_provider/path_provider.dart";
import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';
import 'package:async/async.dart';
class DBFactory {
  static final DBFactory _dbFactory = new DBFactory._internal();
  DBFactory._internal();
  static DBFactory get instance => _dbFactory;
  static Database _database;
  final _initDBMemoizer = AsyncMemoizer<Database>();
  Future<Database> get database async {
    if (_database != null)
      return _database;
    _database = await _initDBMemoizer.runOnce(() async {
      return await _initDB();
    });
    return _database;
  }
  Future<Database> _initDB() async {
    String databasePath = await getDatabasesPath();
    String databaseFilePath = join(databasePath, 'data.db');
    return await openDatabase(databaseFilePath, version: 1);
  }
}
class Messages{
  String title;
  String body;
}
class DBWorker{
  DBWorker(){
    print('DBWorker::DBWorker()');
    initWorker();}
  var db;
  void initWorker() async {
    print('DBWorker::initWorker()');
    var lock = new Lock();
    lock.synchronized(() async {await initDB();});
  }
  Future initDB() async {
    print('DBWorker::initDB()');
    db = await DBFactory.instance.database;
    setUpUserInfoTable();
    setUpMorningMessagesTable();
    setUpNoonMessagesTable();
    setUpAfternoonMessagesTable();
    setUpEveningMessagesTable();
    setUpLateNightMessagesTable();
  }
  void setUpUserInfoTable() async {
    print("DBWorker::setUpUserInfo()");
    await db.transaction((txn) async {
      txn.execute("CREATE TABLE IF NOT EXISTS userInfo ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name Text);");
    });
    await db.transaction((txn) async {
      txn.rawInsert('INSERT INTO userInfo (name) VALUES (?)', ['Manar']);
    });

  }
  void setUpMorningMessagesTable() async {
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
    _insertMorningMessages();
  }
  void _insertMorningMessages() async {
    await db.transaction((txn) async {
      txn.rawInsert('INSERT INTO morningMessages (title, body) VALUES (?, ?)',
          ['Good Morning ', 'Such a beautiful day! Do not forget to have a nice breakfast.']
      );
    });
  }
  void setUpNoonMessagesTable() async {
    print("DBWorker::setUpNoonMessagesTable()");
    await db.transaction((txn) async {
      txn.execute("CREATE TABLE IF NOT EXISTS noonMessages ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "title TEXT,"
          "body TEXT"
          ");"
      );
    });
    _insertNoonMessages();
  }
  void _insertNoonMessages() async {
    await db.transaction((txn) async {
      txn.rawInsert('INSERT INTO noonMessages (title, body) VALUES (?, ?)',
          ['Hello there!',
            'Still have a long day ahead? What about having a small break getting some fresh air?']
      );
    });
  }
  void setUpAfternoonMessagesTable() async {
    print("DBWorker::setUpAfternoonMessagesTable()");
    await db.transaction((txn) async {
      txn.execute('CREATE TABLE IF NOT EXISTS afternoonMessages ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'title TEXT,'
          'body TEXT'
          ');'
      );
    });
    _insertAfternoonMessages();
  }
  void _insertAfternoonMessages() async{
    await db.transaction((txn) async {
      txn.rawInsert('INSERT INTO afternoonMessages (title, body) VALUES (?, ?), (?, ?)',
        ['Good Afternoon ', 'Maybe it is a good time to check your email!',
          'Hello there! ', 'Your body will thank you for a 15-30 minutes nap :)'],
      );
    });
  }
  void setUpEveningMessagesTable() async {
    print("DBWorker::setUpEveningMessagesTable()");
    await db.transaction((txn) async {
      txn.execute('CREATE TABLE IF NOT EXISTS eveningMessages ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'title TEXT,'
          'body TEXT'
          ');');
    });
   _insertEveningMessages();
  }
  void _insertEveningMessages() async {
    db.transaction((txn) async {
      txn.rawInsert('INSERT INTO eveningMessages (title, body) VALUES (?, ?)',
          ['Good Evening ', 'A family dinner is an absolutely awesome idea :)']
      );
    });
  }
  void setUpLateNightMessagesTable() async {
    print("DBWorker::setUpLateNightMessagesTable()");
    await db.transaction((txn) async {
      txn.execute('CREATE TABLE IF NOT EXISTS lateNightMessages ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'title TEXT,'
          'body TEXT'
          ');');
    });
    _insertLateEveningMessages();
  }
  void _insertLateEveningMessages() async {
    db.transaction((txn) async {
      txn.rawInsert('INSERT INTO lateNightMessages (title, body) VALUES (?, ?), (?, ?)',
          ['Good night ', 'You deserve 7-8 hours of uninterrupted sleep :)',
            'Good night ', 'Maybe you would like to turn off Wifi before going to bed!']
      );
    });
  }
  Future<Messages> getMorningMessage() async {
    print("DBWorker::getMorningMessage()");
    var map = await db.query("morningMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Future<Messages> getNoonMessage() async {
    print("DBWorker::getNoonMessage()");
    var map = await db.query("noonMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Future<Messages> getAfternoonMessage() async {
    print("DBWorker::getNoonMessage()");
    var map = await db.query("afterNoonMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Future<Messages> getEveningMessage() async {
    print("DBWorker::getEveningMessage()");
    var map = await db.query("eveningMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Future<Messages> getLateNightMessage() async {
    print("DBWorker::getNoonMessage()");
    var map = await db.query("lateNightMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Messages messageFromMap(dynamic inMap){
    Messages msg = Messages();
    msg.title = inMap["title"];
    msg.body = inMap["body"];
    return msg;
  }
  Future<dynamic> test() async {
    print("DBWorker::test()");
    //return await getRandomMsg();
    return null;
  }
}