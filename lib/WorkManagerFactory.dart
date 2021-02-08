import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:async';
import 'package:app1/Notifications.dart' show notification;
void callbackDispatcher() {
  print('callbackDispatcher()');
  Workmanager.executeTask((taskName, inputData) async {
    print('executeTask');
    switch(taskName) {
      case "periodicMorningMessage":
      print("Replace this print statement with your code that should be executed in the background here");
      try {
        await notification.fireMorningNotification();
      }
      catch (Exception) {
        print('could not notify :(');
      }
      break;
      case "periodicNoonMessage":
        print('noon task is being executed!');
        try { await notification.fireNoonNotification();}
        catch (Exception) {print('could not notify :((');}
      break;
    }
    return Future.value(true);
  });
}
class WorkManagerFactory{
  WorkManagerFactory(){
    print("WorkManagerFactory::WorkManager()");
    _init();
  }
  void _init() async {
    print("WorkManagerFactory::_init()");
    WidgetsFlutterBinding.ensureInitialized();
    await Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
    notification.poke();
  }
  Future<void> _registerMorningTask() async {
    print('WorkManagerFactory::_registerMorningTask()');
    await Workmanager.registerPeriodicTask(
        '1',
        'periodicMorningMessage',
        frequency: Duration(minutes: 15),
        //initialDelay: Duration(minutes: 2),
        inputData: {},
    );
  }
  Future<void> _registerNoonTask() async {
    print('WorkManagerFactory::_registerNoonTask()');
    await Workmanager.registerPeriodicTask(
        '2',
        'periodicNoonMessage',
        frequency: Duration(minutes: 15),
        initialDelay: Duration(minutes: 3),
        inputData: {},
    );
    return;
  }
  void _registerAfternoonTask() async {
    print('WorkManagerFactory::_registerAfternoonTask()');
    await Workmanager.registerPeriodicTask(
        '3',
        'periodicAfternoonMessage',
        frequency: Duration(minutes: 15),
      initialDelay: Duration(seconds: 60),
        inputData: {},
    );
  }
  void _registerEveningTask() async {
    print('WorkManagerFactory::_registerEveningTask()');
    await Workmanager.registerPeriodicTask(
        '4',
        'periodicEveningMessage',
        frequency: Duration(minutes: 15),
        initialDelay: Duration(seconds: 60),
        inputData: {},
    );
  }
  void _registerLateNightTask() async {
    print('WorkManagerFactory::_registerLateNightTask()');
    await Workmanager.registerPeriodicTask(
        '5',
        'periodicLateNightMessage',
        frequency: Duration(minutes: 15),
      initialDelay: Duration(seconds: 60),
        inputData: {},
    );
  }
  void registerPeriodicBackgroundMessages() async {
    print('WorkManagerFactory::registerPeriodicBackgroundMessages()');
    await _registerMorningTask();
    //await _registerNoonTask();
      //_registerAfternoonTask();
      //_registerEveningTask();
      //_registerLateNightTask();
    //}
  }
  void cancelBackgroundProcess() async {
    await Workmanager.cancelAll();
    print("background processes cancelled!");
  }
}