import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Carddata_gen extends StatefulWidget {
  @override
  _Carddata_genState createState() => _Carddata_genState();
}

class _Carddata_genState extends State<Carddata_gen> {
  String? _selectedUniversityId;
  String? _selectedDegreeId;
  String? _selectedDepartment;

  final List<String> predefinedDocumentNames = [
    'S1',
    'S2',
    'S3',
    'S4',
    'S5',
    'S6',
    'S7',
    'S8',
    // Add more predefined names as needed
  ];

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
                          _selectedDegreeId = null;
                          _selectedDepartment = null;
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
                  ],
                );
              },
            ),
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
                      child:
                          Text('No Degrees found for the selected University'),
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
                            _selectedDepartment = null;
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
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            if (_selectedDegreeId != null)
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(
                        '/University/$_selectedUniversityId/Refers/$_selectedDegreeId/Refers')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> departmentSnapshot) {
                  if (departmentSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!departmentSnapshot.hasData ||
                      departmentSnapshot.data!.docs.isEmpty) {
                    return const Center(
                      child:
                          Text('No Departments found for the selected Degree'),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select a Department:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Select a Department'),
                        value: _selectedDepartment,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedDepartment = newValue;
                          });
                        },
                        items: departmentSnapshot.data!.docs
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
                    ],
                  );
                },
              ),
            ElevatedButton(
              onPressed: (_selectedUniversityId != null &&
                      _selectedDegreeId != null &&
                      _selectedDepartment != null)
                  ? () {
                      _createSubcollections();
                    }
                  : null,
              child: const Text('Create Subcollections',
                  style: TextStyle(color: Colors.white)),
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

  Future<void> _createSubcollections() async {
    try {
      for (String semester in predefinedDocumentNames) {
        String path =
            '/University/$_selectedUniversityId/Refers/$_selectedDegreeId/Refers/$_selectedDepartment/Refers/$semester';
        final Map<String, dynamic> semesterDocument = {
          'University': _selectedUniversityId,
          'Degree': _selectedDegreeId,
          'Department': _selectedDepartment,
          'Semester': semester,
        };

        await FirebaseFirestore.instance.doc(path).set(semesterDocument);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Semester documents created successfully.'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create semester documents: $error'),
        ),
      );
    }
  }
}
