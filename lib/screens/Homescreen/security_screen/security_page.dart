import 'package:edumike/screens/Homescreen/security_screen/change_password.dart';
import 'package:edumike/screens/loginscreen/forgot_password_screen.dart';
import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add Account'),
            onTap: () {
              // Add onTap functionality for Add Account
              print('Add Account tapped');
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete Account'),
            onTap: () {
              // Add onTap functionality for Delete Account
              print('Delete Account tapped');
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Reset Password'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen()));
              print('Reset password  tapped');
            },
          ),
          ListTile(
            leading: const Icon(Icons.key),
            title: const Text('Change your password'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdatePasswordPage()));
              print('Email  tapped');
            },
          ),
          // Add more ListTiles for other security options
        ],
      ),
    );
  }
}
