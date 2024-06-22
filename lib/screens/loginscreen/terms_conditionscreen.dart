import 'package:edumike/screens/Homescreen/homemainpage_container_screen/homemainpage_container_screen.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please read the following terms and conditions carefully before using our services:',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text('1. You must be at least 18 years old to use our services.'),
            const Text('2. You agree to abide by all applicable laws and regulations.'),
            const Text('3. We reserve the right to suspend or terminate your account if you violate any of our terms.'),
            const SizedBox(height: 16.0),
            const Text('By using our services, you agree to these terms and conditions.'),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
                const Text('I have read and accept the terms and conditions'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isChecked ? () {
           Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const HomemainpageContainerScreen()), // Replace HomePage with your actual homepage widget
                      );
          // Navigate to the next page or perform any action
          // when the checkbox is checked and the button is pressed.
        } : null,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
