import 'package:device_info_plus/device_info_plus.dart';
import 'package:edumike/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,   
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(const MyApp());

  
  AndroidDeviceInfo? androidInfo;
  try {
    androidInfo = await DeviceInfoPlugin().androidInfo;
    print('Android version: ${androidInfo.version}');
  } catch (e) {
    print('Failed to get Android version: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          
          theme: theme,
          title: 'EduWise',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.authScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
