import 'dart:io'; // Import the 'File' class
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  TextEditingController _pdfNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Upload'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _pdfNameController,
              decoration: InputDecoration(labelText: 'PDF Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String pdfName = _pdfNameController.text.trim();
                if (pdfName.isNotEmpty) {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
                  if (result != null) {
                    String pdfPath = result.files.first.path ?? '';
                    await uploadPDF(pdfName, pdfPath);
                  }
                } else {
                  // Show an error message for an empty PDF name
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please enter a PDF name.'),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              child: Text('Upload PDF'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadPDF(String pdfName, String pdfPath) async {
    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('pdfs/$pdfName.pdf');
      UploadTask uploadTask = storageReference.putFile(File(pdfPath));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String pdfUrl = await storageReference.getDownloadURL();

      // Store the PDF URL and name in Firestore
      await FirebaseFirestore.instance.collection('/University/A.P.J. Abdul Kalam Technological University/Refers/B.Tech/Refers/Computer Science and Engineering/Refers/S1/Refers/BASICS OF CIVIL & MECHANICAL ENGINEERING/Refers/SYLLABUS/Refers').add({
        'pdfName': pdfName,
        'pdfUrl': pdfUrl,
      });

      print("PDF uploaded successfully!");
    } catch (e) {
      print("Error uploading PDF: $e");
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error uploading PDF. Please try again.'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}

void main() => runApp(MaterialApp(home: UploadScreen()));
