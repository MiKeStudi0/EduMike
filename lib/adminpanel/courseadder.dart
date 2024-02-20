import 'package:edumike/adminpanel/categoryupload.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseUpload extends StatefulWidget {
  @override
  _CourseUploadState createState() => _CourseUploadState();
}

class _CourseUploadState extends State<CourseUpload> {
  String? _selectedUniversityId;
  String? _selectedDegreeId;
  String? _selectedPropertyId;
  String? _selectedSemesterId;
  String? _selectedPath;
  String? _newUploadPath;

  final TextEditingController _documentIdController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _courseCreditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Select a University ID'),
                        value: _selectedUniversityId,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedUniversityId = newValue;
                            _selectedDegreeId = null;
                            _selectedPropertyId = null;
                            _selectedSemesterId =
                                null; // Reset selected semester
                            _selectedPath = null; // Reset selected path
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text('Select a Degree'),
                                  value: _selectedDegreeId,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedDegreeId = newValue;
                                      _selectedPropertyId = null;
                                      _selectedSemesterId =
                                          null; // Reset selected semester
                                      _selectedPath =
                                          null; // Reset selected path
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
                      const SizedBox(height: 20),
                      if (_selectedDegreeId != null)
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(
                                  '/University/$_selectedUniversityId/Refers/$_selectedDegreeId/Refers')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> propertySnapshot) {
                            if (propertySnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (!propertySnapshot.hasData ||
                                propertySnapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text(
                                    'No Course found for the selected Degree'),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Select a Course:',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text('Select a Course'),
                                  value: _selectedPropertyId,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedPropertyId = newValue;
                                      _selectedSemesterId =
                                          null; // Reset selected semester
                                      _updateSelectedPath(); // Update selected path
                                    });
                                  },
                                  items: propertySnapshot.data!.docs
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
              if (_selectedPath != null) ...[
                const SizedBox(height: 20),
                const Text(
                  'Select Semester:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(_selectedPath!)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('No Semester found'),
                      );
                    }
                    return DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text('Select a Semester'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSemesterId = newValue;
                          _newUploadPath =
                              '$_selectedPath/$_selectedSemesterId/Refers';
                        });
                      },
                      value: _selectedSemesterId,
                      items:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        return DropdownMenuItem<String>(
                          value: document.id,
                          child: Text(
                            document.id,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
              const SizedBox(height: 20),
              TextField(
                controller: _documentIdController,
                decoration: const InputDecoration(labelText: 'Course ID'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _courseNameController,
                decoration: const InputDecoration(labelText: 'Course Name'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _courseCodeController,
                decoration: const InputDecoration(labelText: 'Course Code'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _courseCreditController,
                decoration: const InputDecoration(labelText: 'Course Credit'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Get document ID and data from text fields
                  String documentId = _documentIdController.text.trim();
                  String courseName = _courseNameController.text.trim();
                  String courseCode = _courseCodeController.text.trim();
                  String courseCredit = _courseCreditController.text.trim();

                  // Example data to be uploaded
                  Map<String, dynamic> data = {
                    'courseName': courseName,
                    'courseCode': courseCode,
                    'courseCredit': courseCredit,
                    // Include Course Credit
                    // Add more fields as needed
                  };

                  // Upload data
                  DocumentReference documentRef = FirebaseFirestore.instance
                      .doc('$_newUploadPath/$documentId');

                  await documentRef.set(data);

                  // Display a message after successful upload
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Data uploaded successfully for document ID: $documentId'),
                    ),
                  );
                },
                child: const Text('Upload Data'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the second screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryUpload()),
                  );
                },
                child: Text('Course Screen',
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CourseUpload()));
                  },
                  child:
                      Text("Generator", style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }

  void _updateSelectedPath() {
    setState(() {
      _selectedPath =
          '/University/$_selectedUniversityId/Refers/$_selectedDegreeId/Refers/$_selectedPropertyId/Refers';
    });
  }

  @override
  void dispose() {
    _documentIdController.dispose();
    _courseNameController.dispose();
    _courseCodeController.dispose();
    _courseCreditController.dispose();
    super.dispose();
  }
}
