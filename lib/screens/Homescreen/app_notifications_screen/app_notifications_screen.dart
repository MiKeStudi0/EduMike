import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppNotificationsScreen extends StatefulWidget {
  const AppNotificationsScreen({Key? key}) : super(key: key);

  @override
  _AppNotificationsScreenState createState() => _AppNotificationsScreenState();
}

class _AppNotificationsScreenState extends State<AppNotificationsScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  List<String> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
    _setupFirebaseMessaging();
  }

  void _setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.notification?.title}");
      setState(() {
        _notifications.add(_getMessageText(message));
        _saveNotifications();
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: ${message.notification?.title}");
      setState(() {
        _notifications.add(_getMessageText(message));
        _saveNotifications();
      });
    });

    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
    });
  }

  Future<void> _loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notifications = prefs.getStringList('notifications') ?? [];
    });
  }

  Future<void> _saveNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notifications', _notifications);
  }

  String _getMessageText(RemoteMessage message) {
    // Extract notification text from message
    String title = message.notification?.title ?? '';
    String body = message.notification?.body ?? '';
    return '$title: $body';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 153, 193, 227),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ListTile(
                leading: const Icon(Icons.notification_important), // Icon before text
                title: Text(
                  _notifications[index].split(":")[0],// Custom text
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                 _notifications[index].split(":")[1].trim(), // Custom subtext
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
