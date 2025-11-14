import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._privateConstructor();
  static final NotificationService instance =
      NotificationService._privateConstructor();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize(BuildContext context) async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      return;
    }
    final token = await _fcm.getToken();
    print("FCM Token: $token");
    await _initializeLocalNotifications();
    _setupListeners(context);
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initIOS = DarwinInitializationSettings();
    const InitializationSettings initSettings = InitializationSettings(
      android: initAndroid,
      iOS: initIOS,
    );

    await _localNotifications.initialize(initSettings);
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'Notificaciones Importantes',
      description: 'Canal para notificaciones importantes.',
      importance: Importance.max,
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  void _setupListeners(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'Notificaciones Importantes',
              channelDescription: 'Canal para notificaciones importantes.',
              icon: android.smallIcon,
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessageNavigation(context, message);
    });

    _fcm.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleMessageNavigation(context, message);
      }
    });
  }

  void _handleMessageNavigation(BuildContext context, RemoteMessage message) {
    if (context.mounted) {
      Navigator.of(context).pushNamed('/home');
    }
  }
}
