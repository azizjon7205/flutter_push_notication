import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.high,
      playSound: true);

  //NOTIFICATION SETTINGS
  static final InitializationSettings notificationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    ),
  );

  //NOTIFICATION DETAILS
  static final NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.high,
        color: Colors.blue,
        playSound: true,
        icon: '@mipmap/ic_launcher'
    ),
    iOS: DarwinNotificationDetails(),
  );

  static Future<void> init() async {

    var initAndroidSetting =
        const AndroidInitializationSettings('@mipmap/launcher');
    var initIosSetting = const DarwinInitializationSettings();
    var initSetting = InitializationSettings(
        android: initAndroidSetting, iOS: initIosSetting);

    await flutterLocalNotificationsPlugin.initialize(notificationSettings);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static showNotification(String title, String body){

    flutterLocalNotificationsPlugin.show(0, 'Title $title', "Message: $body", notificationDetails);
  }

}
