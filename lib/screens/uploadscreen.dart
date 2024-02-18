import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadDataPage extends StatefulWidget {
  @override
  _UploadDataPageState createState() => _UploadDataPageState();
}

class _UploadDataPageState extends State<UploadDataPage> {
  final CollectionReference<
      Map<String,
          dynamic>> physicsCollection = FirebaseFirestore.instance.collection(
      '/University/A.P.J. Abdul Kalam Technological University/B.Tech/Computer Science and Engineering/S1/BASICS OF CIVIL & MECHANICAL ENGINEERING/heloo');

  TextEditingController _field1Controller = TextEditingController();
  TextEditingController _field2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _field1Controller,
              decoration: InputDecoration(labelText: 'Field 1'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _field2Controller,
              decoration: InputDecoration(labelText: 'Field 2'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Get data from text fields
                String field1 = _field1Controller.text.trim();
                String field2 = _field2Controller.text.trim();

                // Example data to be uploaded
                Map<String, dynamic> data = {
                  'field1': field1,
                  'field2': field2,
                  // Add more fields as needed
                };

                // Upload data
                physicsCollection.add(data).then((value) {
                  print("Data Uploaded");
                  // Clear text fields after successful upload
                  _field1Controller.clear();
                  _field2Controller.clear();
                }).catchError(
                    (error) => print("Failed to upload data: $error"));
              },
              child: Text('Upload Data'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _field1Controller.dispose();
    _field2Controller.dispose();
    super.dispose();
  }
}
