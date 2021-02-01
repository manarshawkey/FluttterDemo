import 'package:flutter/cupertino.dart';
import 'package:workmanager/workmanager.dart';
import 'package:app1/Notification.dart' show notification;
import 'dart:async';

const taskName = 'showNotification';
void callbackDispatcher(){
  Workmanager.executeTask((taskName, inputData) {
    notification.showNotification("inTitle", "inMessage");
    return Future.value(true);
  });
}
class WorkManagerFactory{
  WorkManagerFactory._(){
    print("WorkManagerFactory::WorkManager._()");
    init();
  }
  Future<void> init() async {
    print("WorkManagerFactory::init()");
    WidgetsFlutterBinding.ensureInitialized();
    Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
    Workmanager.registerPeriodicTask(
        '1',
        taskName,
      frequency: Duration(minutes: 15),
      initialDelay: Duration(seconds: 5)
    );
    //Workmanager.registerPeriodicTask(
      //  taskName,
        //'showing a notification',
        //frequency: Duration(minutes: 15),
        //initialDelay: Duration(seconds: 10)
    //);
    print("initialization done!");
  }
  void sayHello(){
    print("hello from WorkManagerFactory!");
  }
}
WorkManagerFactory workManager = WorkManagerFactory._();
