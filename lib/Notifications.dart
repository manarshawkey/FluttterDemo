//import 'dart:ffi';
import 'package:app1/DBWorker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';
import 'dart:async';
class Notifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var dbWorker = DBWorker();
  Notifications._(){
    print("Notifications::Notifications._()");
    _init();
  }
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
  Future <void> fireMorningNotification() async {
    print("Notification::fireMorningNotification()");
    Messages message = await dbWorker.getMorningMessage();
    print(message.title + message.body);
    await _showNotification(message.title, message.body);
  }
  Future<void> fireNoonNotification() async {
    print('Notification::fireNoonNotification()');
    Messages message = await dbWorker.getNoonMessage();
    await _showNotification(message.title, message.body);
  }
  /*Future <void> fireAfternoonNotification() async {
    message = await dbWorker.getAfternoonMessage();
    message.type = 'afternoon';
    await _showNotification(message.title, message.body);
  }
  Future<void> fireEveningNotification() async {
    print("firing a morning notification!");
    message = await dbWorker.getEveningMessage();
    message.type = 'evening';
    await _showNotification(message.title, message.body);
  }
  Future<void> fireLateNightNotification() async {
    print('Notification::fireLateNightNotification()');
    message = await dbWorker.getLateNightMessage();
    message.type = 'lateNight';
    await _showNotification(message.title, message.body);
  }*/
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
var notification = Notifications._();