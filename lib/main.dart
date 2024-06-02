import 'dart:async';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'notification_service.dart';
import 'work_always.dart';

void main() {
  runApp(const MyApp());
}

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
  // final NotificationServiceWorkAlaways notificationServiceWorkAlaways =
  // NotificationServiceWorkAlaways();
  final CombinedNotificationService notificationService = CombinedNotificationService();

  late Timer _timer;
  int _currentIndex = 0;
  final List<String> _dataList = ["Data 1", "Data 2", "Data 3"];

  @override
  void initState() {
    super.initState();
    _startSendingNotifications();
    _requestNotificationPermission();

  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  Future<void> _requestNotificationPermission() async {
    PermissionStatus permissionStatus = await Permission.notification.request();
    if (permissionStatus.isGranted) {
      // Permission is granted, proceed with app logic
    } else {
      // Permission is not granted, show a dialog or message to the user
    }
  }
  void _startSendingNotifications() {
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      _sendNotification();
    });
  }

  void _sendNotification() {
    if (_dataList.isNotEmpty) {
      String currentItem = _dataList[_currentIndex];
      CombinedNotificationService.workNotification(
        id: _currentIndex,
        title: 'Scheduled Notification',
        body: 'This is a scheduled notification: $currentItem',
        dataList: _dataList,
      );

      // Update the index to point to the next item in the list
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
              CombinedNotificationService.showNotification(
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
                await CombinedNotificationService.scheduleNotification(
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
