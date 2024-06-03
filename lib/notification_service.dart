import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

import 'model.dart';

class NotificationServices {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Initialize settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialize settings for iOS (Darwin)
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    // Combine both platform initialization settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    // Create notification channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channelId', // id
      'channelName', // name
      // 'chandnelId',
      description: 'This is the description of the channel.', // description
      importance: Importance.high,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // For handling notification when app is in foreground
  static Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // Handle the notification received
    print('Received notification: $title $body');
  }

  // For handling notification when app is in background or terminated
  static Future<void> onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    // Handle notification tapped logic here
    final String? payload = notificationResponse.payload;
    print('Notification tapped with payload: $payload');
    if (payload != null) {
      // Handle the payload
    }
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channelId', // id
      'channelName', // name
      channelDescription: 'This is the description of the channel.',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher', // Ensure the icon is set
    );
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    tz.initializeTimeZones();
    final tz.TZDateTime scheduledTZDate =
        tz.TZDateTime.from(scheduledDate, tz.local);

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channelId', // id
      'channelName', // name
      channelDescription: 'This is the description of the channel.',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher', // Ensure the icon is set
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    try {
      await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledTZDate,
        platformDetails,
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      print('Notification scheduled: $title $body at $scheduledDate');
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  static Future<void> workNotification({
    int? id,
    String? title,
    String? body,
    List<NotificationItem>? dataList,
  }) async {
    if (id == null) {
      print('Error: Notification ID is null');
      return;
    }

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'list_notification_channel',
      'Notification to display a list',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher', // Ensure the icon is set
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    String? dataStr = dataList?.map((item) => '${item.title}\n${item.body}').join("\n");

    try {
      await _notificationsPlugin.show(
        id,
        title,
        '$body\n\n$dataStr',
        platformChannelSpecifics,
      );
      print('Notification shown: $title $body');
    } catch (e) {
      print('Error showing notification: $e');
    }
  }
}
