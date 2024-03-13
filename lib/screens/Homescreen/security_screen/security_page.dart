import 'package:flutter/material.dart';

class SecurityScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Security Notification'),
            onTap: () {
              // Add onTap functionality for Delete Account
              print('Delete Account tapped');
            },
          ),
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
            leading: const Icon(Icons.email),
            title: const Text('Email Address'),
            onTap: () {
              // Add onTap functionality for Delete Account
              print('Delete Account tapped');
            },
          ),
          // Add more ListTiles for other security options
        ],
      ),
    );
  }
}
