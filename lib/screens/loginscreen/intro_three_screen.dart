import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class introThreeScreen extends StatefulWidget {
  const introThreeScreen({super.key});

  @override
  State<introThreeScreen> createState() => _introThreeScreenState();
}

class _introThreeScreenState extends State<introThreeScreen> {
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
