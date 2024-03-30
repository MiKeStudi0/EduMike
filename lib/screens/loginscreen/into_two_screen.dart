import 'package:edumike/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class introTwoScreen extends StatefulWidget {
  const introTwoScreen({super.key});

  @override
  State<introTwoScreen> createState() => _introTwoScreenState();
}

class _introTwoScreenState extends State<introTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         backgroundColor: appTheme.gray50,
        body:  Container(
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
        ),
      ),
    );
  }
}
