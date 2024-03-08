import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AppNotificationsScreen extends StatefulWidget {
  const AppNotificationsScreen({Key? key}) : super(key: key);

  @override
  _AppNotificationsScreenState createState() => _AppNotificationsScreenState();
}

class _AppNotificationsScreenState extends State<AppNotificationsScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestPermission(); // Request permission for receiving messages
    _initializeFirebaseMessaging();
  }

  void _initializeFirebaseMessaging() {
    // Listen to incoming messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received in foreground: ${message.notification!.body}");
      // Handle the received message, e.g., display a notification
      // Display notification or update UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FCM Demo'),
      ),
      body: Center(
        child: Text('App Notifications Screen'),
      ),
    );
  }
}
