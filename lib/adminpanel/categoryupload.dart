import 'dart:io';

import 'package:edumike/adminpanel/coursegenerator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CategoryUpload extends StatefulWidget {
  @override
  _CategoryUploadState createState() => _CategoryUploadState();
}

class _CategoryUploadState extends State<CategoryUpload> {
  String? _selectedUniversityId;
  String? _selectedDegreeId;
  String? _selectedPropertyId;
  String? _selectedSemesterId;
  String? _selectedPath;
  String? _newUploadPath;

  final TextEditingController _documentIdController = TextEditingController();
  final TextEditingController _field1Controller = TextEditingController();
  final TextEditingController _field2Controller = TextEditingController();
  String? _filePath;
  String? _pdfUrl;

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
                decoration: const InputDecoration(labelText: 'Document ID'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _field1Controller,
                decoration: const InputDecoration(labelText: 'Field 1'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _field2Controller,
                decoration: const InputDecoration(labelText: 'Field 2'),
              ),
              const SizedBox(height: 16.0),
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
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: const Text("Please select a PDF file."),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Select PDF File',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 16.0),
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
                      'pdfUrl': _pdfUrl, // Include PDF URL
                      // Add more fields as needed
                    };

                    // Upload data
                    DocumentReference documentRef = FirebaseFirestore.instance
                        .doc('$_newUploadPath/$documentId');

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
                  child: const Text('Upload Data ..',
                      style: TextStyle(color: Colors.white)),
                ),
              if (_filePath != null) Text('Selected PDF: $_filePath'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CourseGenerator()),
                  );
                },
                child: Text('Category Screen',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
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

    // Get document ID and data from text fields
    String field1 = _field1Controller.text.trim();
    String field2 = _field2Controller.text.trim();

    // Example data to be uploaded
    Map<String, dynamic> data = {
      'field1': field1,
      'field2': field2,
      'pdfUrl': pdfUrl, // Include PDF URL
      // Add more fields as needed
    };

    // Upload data
    DocumentReference documentRef =
        FirebaseFirestore.instance.doc('$_newUploadPath/$documentId');

    await documentRef.set(data);

    setState(() {
      _pdfUrl = pdfUrl;
    });
  }

  @override
  void dispose() {
    _documentIdController.dispose();
    _field1Controller.dispose();
    _field2Controller.dispose();
    super.dispose();
  }

  Future<void> _createSubcollection(String path) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Subcollection created successfully for Path: $path'),
    ));
  }

  void _updateSelectedPath() {
    setState(() {
      _selectedPath =
          '/University/$_selectedUniversityId/Refers/$_selectedDegreeId/Refers/$_selectedPropertyId/Refers';
    });
  }
}
