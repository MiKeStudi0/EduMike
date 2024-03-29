import 'package:edumike/screens/Homescreen/cgpa_calculator_screen/cgpa_calculator_screen.dart';
import 'package:edumike/screens/Homescreen/cgpa_calculator_screen/sgpa_calculator.dart';
import 'package:edumike/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class OptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray5002,
      appBar: AppBar(
        title: const Text('Calculator Options'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) =>
                SGPCalculatorPage()));

                // Navigate to SGPA Calculator screen
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('SGPA Calculator',style:TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) =>
                CGPACalculatorPage()));

                // Navigate to CGPA Calculator screen
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('CGPA Calculator',style:TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}