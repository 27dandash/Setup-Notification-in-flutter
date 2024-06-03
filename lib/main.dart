import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:workmanager/workmanager.dart';
import 'model.dart';
import 'notification_service.dart';
///TODO:How to start Clone This Project :->
// 1- edit MainActivity in android - app -src - main - kotlin - com.example.@ypurappname
// 2- edit AndroidManifest.xml  in android - app -src - main - AndroidManifest
// 3- edit pubspec.yaml
///TODO:Start in that :->
// start to add sound for notification
// start to add workmanger and background services for background

// const String taskName = "backgroundNotificationTask";
void main() {
  runApp(const MyApp());
}
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Workmanager().initialize(
//     callbackDispatcher,
//     isInDebugMode: true,
//   );
//   scheduleBackgroundTask();
//   runApp(MyApp());
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotificationSender(),
    );
  }
}

class NotificationSender extends StatefulWidget {
  const NotificationSender({super.key});

  @override
  _NotificationSenderState createState() => _NotificationSenderState();
}

class _NotificationSenderState extends State<NotificationSender> {
  late Timer _timer;
  int _currentIndex = 0;
  final List<NotificationItem> _dataList = [
    NotificationItem(title: "Title 1", body: "Body 1"),
    NotificationItem(title: "Title 2", body: "Body 2"),
    NotificationItem(title: "Title 3", body: "Body 3"),
  ];
  @override
  void initState() {
    super.initState();
    _startSendingNotifications();
    _requestNotificationPermission();
    // _scheduleBackgroundNotification();

  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  Future<void> _requestNotificationPermission() async {
    PermissionStatus permissionStatus = await Permission.notification.request();
    if (permissionStatus.isGranted) {
    } else {
    }
  }
  void _startSendingNotifications() {
    _timer = Timer.periodic(const Duration(minutes: 5), (Timer timer) {
      _sendNotification();
    });
  }
  // void _scheduleBackgroundNotification() {
  //   Workmanager().registerPeriodicTask(
  //     "1",
  //     taskName,
  //     frequency: Duration(minutes: 15), // You can set your desired interval here
  //   );
  // }
  void _sendNotification() {
    if (_dataList.isNotEmpty) {
      NotificationItem currentItem = _dataList[_currentIndex];
      NotificationServices.workNotification(
        id: _currentIndex,
        title: 'Scheduled Notification${currentItem.title}',
        body: 'This is a scheduled notification: ${currentItem.body}',
        dataList: _dataList,
      );
      _currentIndex = (_currentIndex + 1) % _dataList.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Sender'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              NotificationServices.showNotification(
                id: 0,
                title: 'Test Notification',
                body: 'This is a test notification',
              );
            },
            child: const Text('Show Notification'),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                DateTime scheduledTime =
                DateTime.now().add(const Duration(seconds: 5));
                await NotificationServices.scheduleNotification(
                  id: 0,
                  title: 'Scheduled Notification',
                  body: 'This is the body of the scheduled notification.',
                  scheduledDate: scheduledTime,
                );
              },
              child: const Text('Schedule Notification'),
            ),
          ),
        ],
      ),
    );
  }
}
