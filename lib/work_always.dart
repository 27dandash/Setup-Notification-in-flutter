// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationServiceWorkAlaways {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   static Future<void> initialize() async {
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: AndroidInitializationSettings('@mipmap/ic_launcher'));
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   static Future<void> workNotification({
//     int? id,
//     String? title,
//     String? body,
//     List<String>? dataList,
//   }) async {
//     final AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'list_notification_channel',
//       'Notification to display a list',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     final NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     String? dataStr = dataList?.join("\n");
//
//     await flutterLocalNotificationsPlugin.show(
//       id!,
//       title,
//       '$body\n\n$dataStr',
//       platformChannelSpecifics,
//     );
//   }
// }
