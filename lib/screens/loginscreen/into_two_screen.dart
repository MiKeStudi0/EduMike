import 'package:flutter/material.dart';

class introTwoScreen extends StatefulWidget {
  const introTwoScreen({super.key});

  @override
  State<introTwoScreen> createState() => _introTwoScreenState();
}

class _introTwoScreenState extends State<introTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(child: Text("Two")),
    );
  }
}
