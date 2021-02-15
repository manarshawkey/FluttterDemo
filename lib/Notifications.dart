//import 'dart:ffi';
import 'package:app1/DBWorker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
class Notifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final Notifications notifications = Notifications._internal();
  factory Notifications(){
    print('Notifications::Notifications()');
    return notifications;
  }
  Notifications._internal(){
    print('Notifications::_internal()');
    _init();
  }
 /* Notifications(){
    print("Notifications::Notifications()");
    _init();
  }*/
  Future _init() async {
    print("Notifications::_init()");
    WidgetsFlutterBinding.ensureInitialized();
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('app_icon');
    InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
        if(payload != null)
          debugPrint('notification payload: ' + payload);
        }
        );
  }
  Future fireMorningNotification() async {
    print("Notification::fireMorningNotification()");
    Messages message = await DBWorker.db.getMorningMessage();
    print(message.title + message.body);
    await _showNotification(message.title, message.body);
  }
  Future<void> fireNoonNotification() async {
    print('Notification::fireNoonNotification()');
    //DBWorker dbWorker = DBWorker();
    Messages message = await DBWorker.db.getNoonMessage();
    await _showNotification(message.title, message.body);
  }
  Future <void> fireAfternoonNotification() async {
    Messages message = await DBWorker.db.getAfternoonMessage();
   // message.type = 'afternoon';
    await _showNotification(message.title, message.body);
  }
  Future<void> fireEveningNotification() async {
    print("firing a morning notification!");
    Messages message = await DBWorker.db.getEveningMessage();
    //message.type = 'evening';
    await _showNotification(message.title, message.body);
  }
  Future<void> fireLateNightNotification() async {
    print('Notification::fireLateNightNotification()');
    Messages message = await DBWorker.db.getLateNightMessage();
   // message.type = 'lateNight';
    await _showNotification(message.title, message.body);
  }
  //Future<void> fireNightNotification(){}
  //Future<void> fireWeekendNotification(){}
  //Future<void> fireSundayNotification(){}
  Future<void> _showNotification(String inTitle, String inMessage) async {
    print('Notification::showNotification()');
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
        styleInformation: BigTextStyleInformation(''),
        ongoing: false,
        playSound: true,
        enableVibration: true
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        inTitle,
        inMessage,
        platformChannelSpecifics,
        payload: 'item x');
    return;
  }
  void poke(){
    print("poking Notification");
  }
}