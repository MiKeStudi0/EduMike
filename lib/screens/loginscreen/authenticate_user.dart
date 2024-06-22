import 'dart:async';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/Homescreen/homemainpage_container_screen/homemainpage_container_screen.dart';
import 'package:edumike/screens/loginscreen/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Delay for 2 seconds before navigating away from the splash screen
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the appropriate screen based on the authentication state
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomemainpageContainerScreen()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const onBoardingScreen()),
          );
        }
      });
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray50,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 15, 79, 184),
                Color.fromARGB(255, 68, 156, 228),
              ],
            ),
          ),
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 36.h, vertical: 156.v),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: CustomImageView(
                  height: 300,
                  width: 300,
                  margin: EdgeInsets.only(bottom: 30.v),
                  imagePath: ImageConstant.imglogo,
                ),
              ),
              const Spacer(),
              Text(
                "Welcome to Eduwise",
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: theme.textTheme.headlineSmall?.fontSize ?? 0,
                ),
              ),
              SizedBox(height: 6.v),
              SizedBox(
                width: 355.h,
                child: Text(
                  "Unlock Knowledge: Your Ultimate Study Companion",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 240, 240, 240),
                    fontSize: theme.textTheme.titleSmall?.fontSize ?? 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
