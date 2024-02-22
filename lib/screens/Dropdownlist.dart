import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreListView extends StatefulWidget {
  @override
  _FirestoreListViewState createState() => _FirestoreListViewState();
}

class _FirestoreListViewState extends State<FirestoreListView> {
  String? _selectedUniversityId;
  String? _selectedDegreeId;
  String? _selectedPropertyId;
  String? _selectedSemesterId;
  String? _selectedPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Select Semester Dropdown'),
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
                          _selectedDegreeId = null;
                          _selectedPropertyId = null;
                          _selectedSemesterId = null; // Reset selected semester
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
                                    _selectedSemesterId =
                                        null; // Reset selected semester
                                    _selectedPath = null; // Reset selected path
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
              Text(
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
                      });
                    },
                    value: _selectedSemesterId,
                    items: snapshot.data!.docs.map((DocumentSnapshot document) {
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
            ElevatedButton(
              onPressed: (_selectedUniversityId != null &&
                      _selectedDegreeId != null &&
                      _selectedPropertyId != null &&
                      _selectedSemesterId != null)
                  ? () {
                      String path =
                          '/University/$_selectedUniversityId/Refers/$_selectedDegreeId/Refers/$_selectedPropertyId/Refers';
                      print('Generated Path: $path');
                      _createSubcollection(path);
                    }
                  : null,
              child: const Text('Create Subcollection'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
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

void main() {
  runApp(MaterialApp(
    home: FirestoreListView(),
  ));
}
