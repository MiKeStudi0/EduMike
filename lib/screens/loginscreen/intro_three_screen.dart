import 'package:flutter/material.dart';

class introThreeScreen extends StatefulWidget {
  const introThreeScreen({super.key});

  @override
  State<introThreeScreen> createState() => _introThreeScreenState();
}

class _introThreeScreenState extends State<introThreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(child: Text("Three")),
    );
  }
}
