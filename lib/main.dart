import 'package:app1/DBWorker.dart';
import 'package:flutter/material.dart';
import 'Notifications.dart';
import 'dart:io';
import 'dart:async';
import 'package:app1/WorkManagerFactory.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  WorkManagerFactory workManagerFactory = WorkManagerFactory();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A Cool App!"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: Container(
          color: Colors.green[100],
          child: Center(
              child: RaisedButton(
                child: Text ('Test Background process '),
                onPressed: () async {
                  //workManagerFactory.cancelBackgroundProcess();
                  //workManagerFactory.registerPeriodicBackgroundMessages();
                  var dbw = DBWorker();
                  var mess = await dbw.getMorningMessage();
                  print(mess.body);
                },
              )
          )
      )
      , // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}