import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreListView extends StatefulWidget {
  @override
  _FirestoreListViewState createState() => _FirestoreListViewState();
}

class _FirestoreListViewState extends State<FirestoreListView> {
  String? _selectedUniversityId;
  String? _selectedItemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Document IDs Dropdown'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('/University').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> universitySnapshot) {
            if (universitySnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!universitySnapshot.hasData ||
                universitySnapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No universities found'),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select a University ID:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                DropdownButton<String>(
                  isExpanded: true,
                  hint: Text('Select a University ID'),
                  value: _selectedUniversityId,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedUniversityId = newValue;
                      _selectedItemId =
                          null; // Reset the second dropdown when the first dropdown changes
                    });
                  },
                  items: universitySnapshot.data!.docs
                      .map((DocumentSnapshot document) {
                    return DropdownMenuItem<String>(
                      value: document.id,
                      child: Text(
                        document.id,
                        style: TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                if (_selectedUniversityId != null)
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('/University/$_selectedUniversityId/Refers')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> degreeSnapshot) {
                      if (degreeSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!degreeSnapshot.hasData ||
                          degreeSnapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text(
                              'No Degrees found for the selected University'),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select a Degree:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          DropdownButton<String>(
                            isExpanded: true,
                            hint: Text('Select a Degree'),
                            value: _selectedItemId,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedItemId = newValue;
                              });
                            },
                            items: degreeSnapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              return DropdownMenuItem<String>(
                                value: document.id,
                                child: Text(
                                  document.id,
                                  style: TextStyle(fontSize: 14),
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
      ),
    );
  }
}
