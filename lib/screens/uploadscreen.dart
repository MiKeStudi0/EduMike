import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadDataPage extends StatefulWidget {
  @override
  _UploadDataPageState createState() => _UploadDataPageState();
}

class _UploadDataPageState extends State<UploadDataPage> {
  final TextEditingController _documentIdController = TextEditingController();
  final TextEditingController _field1Controller = TextEditingController();
  final TextEditingController _field2Controller = TextEditingController();
  String? _filePath;

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
              controller: _documentIdController,
              decoration: InputDecoration(labelText: 'Document ID'),
            ),
            SizedBox(height: 16.0),
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
              onPressed: () async {
                // Select PDF file
                String? filePath = await _pickPDFFile();
                if (filePath != null) {
                  setState(() {
                    _filePath = filePath;
                  });
                } else {
                  // Show alert if no file selected
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text("Please select a PDF file."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Select PDF File'),
            ),
            SizedBox(height: 16.0),
            if (_filePath != null)
              ElevatedButton(
                onPressed: () async {
                  // Get document ID and data from text fields
                  String documentId = _documentIdController.text.trim();
                  String field1 = _field1Controller.text.trim();
                  String field2 = _field2Controller.text.trim();

                  // Example data to be uploaded
                  Map<String, dynamic> data = {
                    'field1': field1,
                    'field2': field2,
                    // Add more fields as needed
                  };

                  // Upload data
                  DocumentReference documentRef = FirebaseFirestore.instance.doc(
                      '/University/A.P.J. Abdul Kalam Technological University/B.Tech/Computer Science and Engineering/S1/BASICS OF CIVIL & MECHANICAL ENGINEERING/heloo/$documentId');

                  await documentRef.set(data);

                  // Upload PDF file
                  await _uploadPDF(documentId);

                  // Clear text fields and file path
                  _documentIdController.clear();
                  _field1Controller.clear();
                  _field2Controller.clear();
                  setState(() {
                    _filePath = null;
                  });
                },
                child: Text('Upload Data'),
              ),
            if (_filePath != null) Text('Selected PDF: $_filePath'),
          ],
        ),
      ),
    );
  }

  Future<String?> _pickPDFFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return result.files.single.path;
    } else {
      // User canceled the picker
      return null;
    }
  }

  Future<void> _uploadPDF(String documentId) async {
    if (_filePath == null) return;

    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('pdfs')
        .child('$documentId.pdf');

    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(_filePath!));

    // Wait for the upload to complete and get the download URL
    String pdfUrl = await (await uploadTask).ref.getDownloadURL();

    print('PDF Uploaded. URL: $pdfUrl');
  }

  @override
  void dispose() {
    _documentIdController.dispose();
    _field1Controller.dispose();
    _field2Controller.dispose();
    super.dispose();
  }
}
