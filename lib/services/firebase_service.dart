
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_push_notication/services/notif_service.dart';
import 'package:flutter_push_notication/services/prefs_service.dart';

Future<void> initFirebase() async{
  await Firebase.initializeApp();

  var messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true
  );

  print('${settings.authorizationStatus}');

  messaging.getToken().then((value) async{
    String fcmToken = value.toString();
    await PrefsManager.saveFCM(fcmToken);
    String token = await PrefsManager.getFCM();
    print('token: $token');
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String title = message.notification?.title ?? '';
    String body = message.notification?.body ?? '';
    print('Message: Title: $title = Body $body');
    print('Message: Data: ${message.data}');
  });

  FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null) {
        NotificationManager.showNotification(notification.title ?? 'TEST', notification.body ?? 'Test body');
      }
    });

  messaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async{
    await Firebase.initializeApp();
    print('Message on Background: ${message.data}');
  });

  return;
}