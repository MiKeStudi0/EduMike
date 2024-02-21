import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RetrieveDocument extends StatefulWidget {
  @override
  _RetrieveDocumentState createState() => _RetrieveDocumentState();
}

class _RetrieveDocumentState extends State<RetrieveDocument> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String subcollectionPath =
      '/University/A.P.J. Abdul Kalam Technological University/Refers/B.Tech/Refers/Computer Science and Engineering/Refers/S1/Refers';
  final String documentId =
      'ENGINEERING PHYSICS A'; // Replace 'your_document_id' with the actual document ID
  String courseCodeData = '';
  // Change to String since you are retrieving a single document
  String courseNameData = '';
  String courseCreditData = '';

  @override
  void initState() {
    super.initState();
    retrieveDataFromSubcollection();
  }

  Future<void> retrieveDataFromSubcollection() async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.doc('$subcollectionPath/$documentId').get();
      var coursecode = documentSnapshot.get('courseCode');
      var courseName = documentSnapshot.get('courseName');
      var courseCredit = documentSnapshot.get('courseCredit');
      setState(() {
        courseCodeData = coursecode.toString();
        courseCreditData = courseCredit.toString();
        courseNameData = courseName.toString();
      });
    } catch (error) {
      print('Error retrieving data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Document Retrieval Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              courseCodeData.isNotEmpty ? courseCodeData : 'Loading...',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              courseNameData.isNotEmpty ? courseNameData : 'Loading...',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              courseCreditData.isNotEmpty ? courseCreditData : 'Loading...',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
