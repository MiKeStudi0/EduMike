import 'package:edumike/adminpanel/semester.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentUpload extends StatefulWidget {
  @override
  _DepartmentUploadState createState() => _DepartmentUploadState();
}

class _DepartmentUploadState extends State<DepartmentUpload> {
  String? _selectedUniversityId;
  String? _selectedDegreeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Document IDs Dropdown'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('/University')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> universitySnapshot) {
                if (universitySnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!universitySnapshot.hasData ||
                    universitySnapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No universities found'),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select a University ID:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text('Select a University ID'),
                      value: _selectedUniversityId,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedUniversityId = newValue;
                        });
                      },
                      items: universitySnapshot.data!.docs
                          .map((DocumentSnapshot document) {
                        return DropdownMenuItem<String>(
                          value: document.id,
                          child: Text(
                            document.id,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    if (_selectedUniversityId != null)
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(
                                '/University/$_selectedUniversityId/Refers')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> degreeSnapshot) {
                          if (degreeSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!degreeSnapshot.hasData ||
                              degreeSnapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text(
                                  'No Degrees found for the selected University'),
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Select a Degree:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text('Select a Degree'),
                                value: _selectedDegreeId,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedDegreeId = newValue;
                                  });
                                },
                                items: degreeSnapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  return DropdownMenuItem<String>(
                                    value: document.id,
                                    child: Text(
                                      document.id,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        },
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  (_selectedUniversityId != null && _selectedDegreeId != null)
                      ? () {
                          String path =
                              '/University/$_selectedUniversityId/Refers/$_selectedDegreeId/Refers';
                          print('Generated Path: $path');
                          _createSubcollection(path);
                        }
                      : null,
              child: const Text('Create Subcollection',
                  style: const TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                primary: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the second screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SemesterUpload()),
                );
              },
              child: const Text('Semester Screen',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createSubcollection(String path) async {
    List<String> names = [
      'Aeronautical Engineering',
      'Agriculture & Farm Engineering',
      'Applied Electronics and Instrumentation Engineering',
      'Artificial Intelligence and Data Science',
      'Artificial Intelligence and Machine Learning',
      'Automation',
      'Automobile Engineering',
      'Biomedical Engineering',
      'Biotechnology',
      'Biotechnology and Biochemical Engineering',
      'Biotechnology and Biochemical Engineering',
      'Chemical Engineering',
      'Civil Engineering',
      'Computer Science and Engineering',
      'Computer Science and Engineering (Cyber Security)',
      'Electrical and Electronics Engineering',
      'Electronics and Biomedical Engineering',
      'Electronics and Communication Engineering',
      'Electronics and Computer Engineering',
      'Electronics and Instrumentation Engineering',
      'Food Engineering and Technology',
      'Food Technology',
      'Industrial Engineering',
      'Information Technology',
      'Mechanical Engineering',
      'Mechanical Engineering (Automobile)',
      'Mechatronics Engineering',
      'Metallurgical and Materials Engineering',
      'Naval Architecture and Ship Building Engineering',
      'Production Engineering',
      'Robotics and Automation',
    ];

    for (String name in names) {
      await FirebaseFirestore.instance
          .collection(path)
          .doc(name)
          .set({'name': name, 'degree': 'B.Tech'});
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Subcollection created successfully!'),
    ));
  }
}
