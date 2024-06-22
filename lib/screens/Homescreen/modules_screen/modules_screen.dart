import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/Homescreen/modules_screen/pdfviewer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ModulesScreen extends StatelessWidget {
  final String? university;
  final String? degree;
  final String? course;
  final String? semester;
  final String? courseName;
  final String? category;

  const ModulesScreen({super.key, 
    this.university,
    this.degree,
    this.course,
    this.semester,
    this.courseName,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    print(
        ' category check  University: $university, Degree: $degree, Course: $course, Semester: $semester');
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 35.h,
            vertical: 17.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.v),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Module",
                            style: CustomTextStyles.titleSmallJostff202244,
                          ),
                          TextSpan(
                            text: " 01 - ",
                            style: CustomTextStyles.titleSmallJostff202244,
                          ),
                          TextSpan(
                            text: "Introduction",
                            style: CustomTextStyles.titleSmallJostff00acea,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgStroke2,
                    height: 5.v,
                    width: 10.h,
                    margin: EdgeInsets.only(
                      left: 7.h,
                      top: 9.v,
                      bottom: 6.v,
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(
                        '/University/$university/Refers/$degree/Refers/$course/Refers/$semester/Refers/$courseName/Refers/$category/Refers')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No PDFs available.'));
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var document = snapshot.data!.docs[index];
                        var pdfName = document.id;
                        var pdfUrl = document['pdfUrl'];

                        return ListTile(
                          title: Text(pdfName),
                          onTap: () {
                            print(
                                'Item tapped: PDF Name: $pdfName, PDF URL: $pdfUrl');
                            _navigateToPdfViewer(context, pdfUrl);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToPdfViewer(BuildContext context, String pdfUrl) {
    print('Navigating to PDF Viewer with URL: $pdfUrl');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfScreen(pdfUrl: pdfUrl),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("Modules"),
    );
  }
}

void main() => runApp(const MaterialApp(home: ModulesScreen()));
