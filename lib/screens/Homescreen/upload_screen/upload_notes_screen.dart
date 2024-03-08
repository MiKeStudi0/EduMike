import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EmailServicePage(),
    );
  }
}

class EmailServicePage extends StatefulWidget {
  @override
  _EmailServicePageState createState() => _EmailServicePageState();
}

class _EmailServicePageState extends State<EmailServicePage> {
  String? _attachmentPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Service'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                String? filePath = await pickAndStoreFile();
                if (filePath != null) {
                  setState(() {
                    _attachmentPath = filePath;
                  });
                }
              },
              child: Text('Pick and Attach File'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _sendEmail();
              },
              child: Text('Send Email with Attachment'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> pickAndStoreFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return result.files.single.path;
    } else {
      // User canceled the picker
      return null;
    }
  }

  Future<void> _sendEmail() async {
    if (_attachmentPath != null) {
      final Email email = Email(
        recipients: ['recipient@example.com'],
        subject: 'File Attachment',
        body: 'Please find the attached file.',
        isHTML: false,
        attachmentPaths: [_attachmentPath!],
      );

      await FlutterEmailSender.send(email);
    } else {
      // No file attached, display a message or prompt the user
      print('No file attached');
    }
  }
}
