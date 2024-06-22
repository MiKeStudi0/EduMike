// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class Syllabus extends StatelessWidget {
  final String university;
  final String degree;
  final String course;
  final String semester;
  final String courseName;
  final String category;

  const Syllabus({super.key, 
    required this.university,
    required this.degree,
    required this.course,
    required this.semester,
    required this.courseName,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final String collectionPath =
        '/University/$university/Refers/$degree/Refers/$course/Refers/$semester/Refers/$courseName/Refers/$category/Refers/';
print('Syllabus: $collectionPath');
    return Scaffold(
      
      appBar: _buildAppBar(context),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(collectionPath)
            .doc(courseName)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>?> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data?.data();
          if (data == null || !data.containsKey('pdfUrl')) {
            return Text('PDF URL not found');
          }

          final String? pdfUrl = data['pdfUrl'];
          if (pdfUrl == null) {
            return Text('PDF URL is null');
          }

          return Center(
            child: PDF(
              autoSpacing: false,
              fitPolicy: FitPolicy.WIDTH,
              pageFling: true,
              fitEachPage: true,
            ).cachedFromUrl(pdfUrl),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'PDF Viewer',
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      ),
      backgroundColor: Color.fromARGB(255, 66, 188, 249),
    );
  }
}
