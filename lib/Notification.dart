//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';
import 'dart:async';
class Notification {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Notification(){
    print("Notification()");
    init();
  }
  void init() async {
    print("Notification()::init()");
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
  Future scheduleMorningNotification(String name, String inMessage) async {
    print("Notification::scheduleMorningNotification()");
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.show(
        0,
        "Good Morning " + name + " :)",
        inMessage,
        const NotificationDetails()
        );
  }
  //Future fireNoonNotification(){}
  //Future fireAfternoonNotification(){}
  //Future fireEveningNotification(){}
  //Future fireNightNotification(){}
  //Future fireWeekendNotification(){}
  //Future fireSundayNotification(){}
  Future showScheduledNotification(String inTitle, String inMessage) async {
    print("Notification::showScheduledNotification()");
    tz.initializeTimeZones();
//    tz.setLocalLocation(tz.getLocation(timeZoneName));
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        inTitle,
        inMessage,
//        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 30)),
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 60)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              styleInformation: BigTextStyleInformation('')
            )
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime
    );
  }
  Future <void> showNotification(String inTitle, String inMessage) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, inTitle, inMessage, platformChannelSpecifics,
        payload: 'item x');
    return;
  }
  void showPeriodicNotifications(String inTitle, String inMessage){
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) => showNotification(inTitle, inMessage));
  }
}
Notification notification = Notification();