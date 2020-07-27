import 'dart:convert';
import 'dart:io';

import 'package:push/model/device.dart';
import 'package:push/push_notification/push_notification_factory.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class PushNotificationConfig {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationDetails platformChannelSpecifics;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static Future<dynamic> _onBackgroundMessage(
      Map<String, dynamic> message) async {
    print('On background message $message');
    return Future<void>.value();
  }

  Future<void> configure() async {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => setDevice(token));

    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'cpe_mobile', 'cpe_mobile', 'canal principal CPE',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          //print('mensagem recebida');
          //setState(() => _message = message["notification"]["body"]);
          _processMessage(message);
        },
        onBackgroundMessage: Platform.isIOS ? null : _onBackgroundMessage,
        onResume: (Map<String, dynamic> message) async {
          print('on resume $message');
          _processMessage(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('on resume $message');
          _processMessage(message);
          //controller.setNumeroRegistro(message['data']['payload']);
        });
  }

  setDevice(String token) async {
    Device device = Device(token: token);
    /*
    await getDeviceDetails(device);
    controller.setDevice(device);
    */

    print('O Token FCM é: $token');
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    return Future<void>.value();
  }

  Future onSelectNotification(String payload) {
    //Get.snackbar("Teste de Notificação", payload);
    //print(payload);
    if (payload != null)
      PushNotificationFactory.create(json.decode(payload))..execute();

    return Future<void>.value();
  }

  void _processMessage(message) {
    _flutterLocalNotificationShow(message);
  }

  void _flutterLocalNotificationShow(message) async {
    String payload;

    if (Platform.isIOS)
      payload = message['payload'];
    else
      payload = message['data']['payload'];

    await flutterLocalNotificationsPlugin.show(
        0,
        message['notification']['title'],
        message['notification']['body'],
        platformChannelSpecifics,
        payload: payload);
  }
}
