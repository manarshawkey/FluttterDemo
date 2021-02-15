import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:async';
import 'package:app1/Notifications.dart';
void callbackDispatcher() {
  print('callbackDispatcher()');
  Workmanager.executeTask((taskName, inputData) async {
    Notifications notifications = Notifications();
    print('executeTask');
    switch(taskName) {
      case "periodicMorningMessage":
      print("Replace this print statement with your code that should be executed in the background here");
      try {
        await notifications.fireMorningNotification();
      }
      catch (Exception) {
        print('could not notify :(');
      }
      break;
      case "periodicNoonMessage":
        print('noon task is being executed!');
        try { await notifications.fireNoonNotification();}
        catch (Exception) {print('could not notify :((');}
      break;
      case 'periodicAfternoonMessage':
        print('Afternoon Message is being executed!');
        try{
          await notifications.fireAfternoonNotification();
        }
        catch(Exception){ print('could not notify :(');}
        break;
      case 'periodicEveningMessage':
        print('Evening Message is being executed!');
        try{
          await notifications.fireEveningNotification();
        }
        catch(Exception){ print('could not notify :(');}
        break;
      case 'periodicLateNightMessage':
        print('Late night Message is being executed!');
        try{
          await notifications.fireLateNightNotification();
        }
        catch(Exception){ print('could not notify :(');}
        break;
    }
    return Future.value(true);
  });
}
class WorkManagerFactory{
  static final WorkManagerFactory workManager = WorkManagerFactory._();
  WorkManagerFactory._(){
    print("WorkManagerFactory::WorkManager()");
    _init();
  }
  void _init() async {
    print("WorkManagerFactory::_init()");
    WidgetsFlutterBinding.ensureInitialized();
    await Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
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
        initialDelay: Duration(minutes: 1),
        inputData: {},
    );
    return;
  }
  Future<void> _registerAfternoonTask() async {
    print('WorkManagerFactory::_registerAfternoonTask()');
    await Workmanager.registerPeriodicTask(
        '3',
        'periodicAfternoonMessage',
        frequency: Duration(minutes: 15),
      initialDelay: Duration(minutes: 1),
        inputData: {},
    );
  }
  Future<void> _registerEveningTask() async {
    print('WorkManagerFactory::_registerEveningTask()');
    await Workmanager.registerPeriodicTask(
        '4',
        'periodicEveningMessage',
        frequency: Duration(minutes: 15),
        initialDelay: Duration(minutes: 3),
        inputData: {},
    );
  }
  Future<void> _registerLateNightTask() async {
    print('WorkManagerFactory::_registerLateNightTask()');
    await Workmanager.registerPeriodicTask(
        '5',
        'periodicLateNightMessage',
        frequency: Duration(minutes: 15),
      initialDelay: Duration(minutes: 4),
        inputData: {},
    );
  }
  void registerPeriodicBackgroundMessages() async {
    print('WorkManagerFactory::registerPeriodicBackgroundMessages()');
    await Workmanager.cancelAll();
    //await _registerMorningTask();
    //await _registerNoonTask();
    await _registerAfternoonTask();
    //await _registerEveningTask();
    //await _registerLateNightTask();
  }
  Future cancelBackgroundProcess() async {
    await Workmanager.cancelAll();
    print("background processes cancelled!");
  }
}