import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/adminpanel/categoryupload.dart';

class CourseUpload extends StatefulWidget {
  @override
  _CourseUploadState createState() => _CourseUploadState();
}

class _CourseUploadState extends State<CourseUpload> {
  String? _selectedUniversityId;
  String? _selectedDegreeId;
  String? _selectedPropertyId;
  String? _selectedSemesterId;
  String? _selectedDocumentId;
  String? _newUploadPath;
  String? _finalUploadPath;
  File? _selectedPdfFile; // New variable to store the selected PDF file

  final TextEditingController _documentIdController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _courseCreditController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String subcollectionPath =
      '/University/A.P.J. Abdul Kalam Technological University/Refers/B.Tech/Refers/Computer Science and Engineering/Refers/S1/Refers';
  final String documentId =
      'LINEAR ALGEBRA AND CALCULUS'; // Replace 'your_document_id' with the actual document ID
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
                            _selectedSemesterId = null;
                            _selectedDocumentId = null;
                            _newUploadPath = null;
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
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              if (_selectedUniversityId != null)
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('/University/$_selectedUniversityId/Refers')
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
                            'No degrees found for the selected university'),
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
                              _selectedPropertyId = null;
                              _selectedSemesterId = null;
                              _selectedDocumentId = null;
                              _newUploadPath = null;
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
                        child: Text('No courses found for the selected degree'),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select a Course:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text('Select a Course'),
                          value: _selectedPropertyId,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedPropertyId = newValue;
                              _selectedSemesterId = null;
                              _selectedDocumentId = null;
                              _newUploadPath = null;
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
              const SizedBox(height: 20),
              if (_selectedPropertyId != null)
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(
                          '/University/$_selectedUniversityId/Refers/$_selectedDegreeId/Refers/$_selectedPropertyId/Refers')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> semesterSnapshot) {
                    if (semesterSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!semesterSnapshot.hasData ||
                        semesterSnapshot.data!.docs.isEmpty) {
                      return const Center(
                        child:
                            Text('No semesters found for the selected course'),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select a Semester:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text('Select a Semester'),
                          value: _selectedSemesterId,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedSemesterId = newValue;
                              _newUploadPath =
                                  '/University/$_selectedUniversityId/Refers/$_selectedDegreeId/Refers/$_selectedPropertyId/Refers/$_selectedSemesterId/Refers';
                              _selectedDocumentId = null;
                            });
                          },
                          items: semesterSnapshot.data!.docs
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
              if (_selectedSemesterId != null)
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(_newUploadPath!)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> documentSnapshot) {
                    if (documentSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!documentSnapshot.hasData ||
                        documentSnapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text(
                            'No documents found for the selected semester'),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select a Document ID:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: const Text('Select a Document ID'),
                          value: _selectedDocumentId,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedDocumentId = newValue;
                              _finalUploadPath =
                                  '$_newUploadPath/$_selectedDocumentId/Refers';
                            });
                          },
                          items: documentSnapshot.data!.docs
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
              ElevatedButton(
                onPressed: _pickPdfFile, // Call the function to pick PDF file
                child: Text(
                    _selectedPdfFile != null ? 'PDF Selected' : 'Select PDF'),
              ),
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
                  String? pdfUrl = await _uploadPdfToStorage();
                  if (pdfUrl != null) {
                    // Get document ID and data from text fields
                    String documentId = _documentIdController.text.trim();
                    String courseName =
                        _courseNameController.text.trim(); //dont remove this
                    String courseCode =
                        _courseCodeController.text.trim(); //dont remove this
                    String courseCredit =
                        _courseCreditController.text.trim(); //dont remove this

                    // Example data to be uploaded
                    Map<String, dynamic> data = {
                      'courseName': courseNameData, //change akiya mathi
                      'courseCode': courseCodeData, //mele ulla name
                      'courseCredit': courseCreditData,
                      'selectedDocumentId':
                          _selectedDocumentId, // Include selected document ID
                      'pdfUrl': pdfUrl // Include PDF URL
                      // Add more fields as needed
                    };

                    // Upload data
                    DocumentReference documentRef = FirebaseFirestore.instance
                        .doc('$_finalUploadPath/$documentId');

                    await documentRef.set(data);

                    // Display a message after successful upload
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Data uploaded successfully for document ID: $documentId'),
                      ),
                    );
                  }
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

  @override
  void dispose() {
    _documentIdController.dispose();
    _courseNameController.dispose();
    _courseCodeController.dispose();
    _courseCreditController.dispose();
    super.dispose();
  }

  // Function to pick a PDF file
  Future<void> _pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedPdfFile = File(result.files.single.path!);
      });
    }
  }

  // Function to upload PDF file to Firebase Storage
  Future<String?> _uploadPdfToStorage() async {
    if (_selectedPdfFile == null) {
      return null;
    }

    Reference storageRef =
        FirebaseStorage.instance.ref().child('pdfs/${_selectedPdfFile!.path}');
    UploadTask uploadTask = storageRef.putFile(_selectedPdfFile!);

    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}