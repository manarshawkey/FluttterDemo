import 'dart:io';
import 'package:sqflite/sqflite.dart';
import "package:path_provider/path_provider.dart";
import 'package:path/path.dart';
class Message{
  String title;
  String body;
}
class DBWorker{
  Directory docsDir = Directory("");
  static Database _db;
  DBWorker._(){
    print("DBWorker::DBWorker._()");
    initDB();
  }
  Future<void> initDB() async{
    print("DBWorker::initDB()");
    _db = await database;
    return null;
  }
  Future get database  async {
    print("DBWorker::get database ");
    if (_db == null) {
      _db = await init();
    } else {
        print("db is not null! yay!!");
    }
    return _db;
  }
  Future<Database> init() async {
    print("DBWorker::init()");
    setDocsDir();
    String path = join(docsDir.path, "demo.db");
    Database db = await openDatabase(path, version: 1,
        singleInstance: true, onOpen: (db){},
        onCreate: (Database inDB, int inVersion)  {}
        );
    setUpUserInfoTable();
    setUpMorningMessagesTable();
    setUpNoonMessagesTable();
    setUpAfternoonMessagesTable();
    setUpEveningMessagesTable();
    setUpLateNightMessagesTable();
    return db;
  }
  void setUpUserInfoTable() async {
    print("DBWorker::setUpUserInfo()");
    Database db = await database;
    await db.execute(
        "CREATE TABLE IF NOT EXISTS userInfo ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "name Text);"
    );
    await db.rawInsert(
        'INSERT INTO userInfo (name) VALUES (?)', ['Manar']);
  }
  void setUpMorningMessagesTable() async {
    print("DBWorker::setUpMorningMessages()");
    Database db = await database;
    await db.execute("CREATE TABLE IF NOT EXISTS morningMessages ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title TEXT,"
        "body TEXT"
        ");"
    );
    await db.rawInsert('INSERT INTO morningMessages (title, body) VALUES (?, ?)',
      ['Good Morning ', 'Such a beautiful day! Do not forget to have a nice breakfast.']
    );
  }
  void setUpNoonMessagesTable() async {
    print("DBWorker::setUpNoonMessagesTable()");
    Database db = await database;
    await db.execute("CREATE TABLE IF NOT EXISTS noonMessages ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title TEXT,"
        "body TEXT"
        ");"
    );
    await db.rawInsert('INSERT INTO noonMessages (title, body) VALUES (?, ?)',
      ['Hello there!',
        'Still have a long day ahead? What about having a small break getting some fresh air?']
    );
  }
  void setUpAfternoonMessagesTable() async {
    print("DBWorker::setUpAfternoonMessagesTable()");
    Database db = await database;
    await db.execute('CREATE TABLE IF NOT EXISTS afternoonMessages ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'title TEXT,'
        'body TEXT'
        ');'
    );
    await db.rawInsert('INSERT INTO afternoonMessages (title, body) VALUES (?, ?), (?, ?)',
        ['Good Afternoon ', 'Maybe it is a good time to check your email!',
          'Hello there! ', 'Your body will thank you for a 15-30 minutes nap :)'],
    );
  }
  void setUpEveningMessagesTable() async {
    print("DBWorker::setUpEveningMessagesTable()");
    Database db = await database;
    await db.execute('CREATE TABLE IF NOT EXISTS eveningMessages ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'title TEXT,'
        'body TEXT'
        ');'
    );
    await db.rawInsert('INSERT INTO eveningMessages (title, body) VALUES (?, ?)',
    ['Good Evening ', 'A family dinner is an absolutely awesome idea :)']
    );
  }
  void setUpLateNightMessagesTable() async {
    print("DBWorker::setUpLateNightMessagesTable()");
    Database db = await database;
    await db.execute('CREATE TABLE IF NOT EXISTS lateNightMessages ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'title TEXT,'
        'body TEXT'
        ');'
    );
    await db.rawInsert('INSERT INTO lateNightMessages (title, body) VALUES (?, ?), (?, ?)',
        ['Good night ', 'You deserve 7-8 hours of uninterrupted sleep :)',
          'Good night ', 'Maybe you would like to turn off Wifi before going to bed!']
    );
  }
  void setDocsDir()async{
    print("DBWorker::SetDocsDir()");
    docsDir = await getApplicationDocumentsDirectory();
  }
  Future<Message> getMorningMessage() async {
    print("DBWorker::getMorningMessage()");
    Database db = await database;
    var map = await db.query("morningMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Future<Message> getNoonMessage() async {
    print("DBWorker::getNoonMessage()");
    Database db = await database;
    var map = await db.query("noonMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Future<Message> getAfternoonMessage() async {
    print("DBWorker::getNoonMessage()");
    Database db = await database;
    var map = await db.query("afterNoonMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Future<Message> getEveningMessage() async {
    print("DBWorker::getEveningMessage()");
    Database db = await database;
    var map = await db.query("eveningMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Future<Message> getLateNightMessage() async {
    print("DBWorker::getNoonMessage()");
    Database db = await database;
    var map = await db.query("lateNightMessages", where: "id = ?", whereArgs: [1]);
    return messageFromMap(map.first);
  }
  Message messageFromMap(dynamic inMap){
    Message msg = Message();
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
//DBWorker db = DBWorker._();