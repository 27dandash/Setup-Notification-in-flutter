// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:workmanager/workmanager.dart';
//
// const String taskName = "backgroundNotificationTask";
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Workmanager().initialize(
//     callbackDispatcher,
//     isInDebugMode: true,
//   );
//   scheduleBackgroundTask();
//   runApp(MyApp());
// }
//
// void scheduleBackgroundTask() {
//   Workmanager().registerPeriodicTask(
//     taskName,
//     taskName,
//     frequency: Duration(hours: 1),
//     inputData: <String, dynamic>{},
//   );
// }
//
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
//       case taskName:
//         await NotificationServices.initialize();
//         await NotificationServices.showNotification(
//           id: 0,
//           title: 'Scheduled Notification',
//           body: 'This is a scheduled notification',
//         );
//         break;
//       default:
//         print("Unknown task");
//     }
//     return Future.value(true);
//   });
// }
//
// class NotificationServices {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   static Future<void> initialize() async {
//     // Initialize settings for Android
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     // Initialize settings for iOS (Darwin)
//     const IOSInitializationSettings initializationSettingsIOS =
//     IOSInitializationSettings();
//
//     // Combine both platform initialization settings
//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     await _notificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
//     );
//
//     // Create notification channel for Android
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'channelId', // id
//       'channelName', // name
//       description: 'This is the description of the channel.', // description
//       importance: Importance.high,
//     );
//
//     await _notificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//   }
//
//   static Future<void> onDidReceiveNotificationResponse(
//       NotificationResponse notificationResponse) async {
//     // Handle notification tapped logic here
//     final String? payload = notificationResponse.payload;
//     print('Notification tapped with payload: $payload');
//     if (payload != null) {
//       // Handle the payload
//     }
//   }
//
//   static Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//     String? payload,
//   }) async {
//     const AndroidNotificationDetails androidDetails =
//     AndroidNotificationDetails(
//       'channelId', // id
//       'channelName', // name
//       channelDescription: 'This is the description of the channel.',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     const NotificationDetails platformDetails = NotificationDetails(
//       android: androidDetails,
//     );
//
//     try {
//       await _notificationsPlugin.show(
//         id,
//         title,
//         body,
//         platformDetails,
//         payload: payload,
//       );
//       print('Notification shown: $title $body');
//     } catch (e) {
//       print('Error showing notification: $e');
//     }
//   }
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Background Notifications"),
//       ),
//       body: Center(
//         child: Text(
//           'Welcome to Background Notifications!',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
//
