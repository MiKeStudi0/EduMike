import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreListView extends StatefulWidget {
  @override
  _FirestoreListViewState createState() => _FirestoreListViewState();
}

class _FirestoreListViewState extends State<FirestoreListView> {
  String? _selectedItemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Document IDs Dropdown'),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('/University').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No documents found'),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  hint: Text('Select a University ID'),
                  value: _selectedItemId,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItemId = newValue;
                    });
                  },
                  items: snapshot.data!.docs.map((DocumentSnapshot document) {
                    return DropdownMenuItem<String>(
                      value: document.id,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: Text(
                          document.id,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addNamesWithSubcollections();
                  },
                  child: Text('Add Names with Subcollections'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _addNamesWithSubcollections() async {
    final FirebaseService firebaseService = FirebaseService();

    // List of universities with names and subcollection data to add
    final List<Map<String, dynamic>> universitiesAndData = [
      {
        'name': 'A.P.J. Abdul Kalam Technological University',
        'subcollectionData': [
          'B.Arch',
          'B.Des',
          'B.Pharma',
          'B.Tech',
          'B.Voc',
          'BBA',
          'BCA',
          'BFA',
          'BHMCT',
          'M.Arch',
          'M.Plan',
          'M.Sc',
          'M.Tech',
          'MBA|PGDM',
          'MCA',
          'Ph.D',
          // Add more document IDs for subcollection as needed
        ]
      },
      // Add more universities and subcollection data as needed
    ];

    // Add each university with its subcollection data
    for (var entry in universitiesAndData) {
      await firebaseService.addUniversityWithSubcollections(
          entry['name'], entry['subcollectionData']);
    }
  }
}

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUniversityWithSubcollections(
      String universityName, List<String> subcollectionData) async {
    try {
      // Create a document reference for the university
      DocumentReference universityRef =
          _firestore.collection('University').doc(universityName);

      // Create a subcollection for the university
      CollectionReference subcollectionRef = universityRef.collection('Refers');

      // Add documents within the subcollection
      for (var documentId in subcollectionData) {
        await subcollectionRef.doc(documentId).set(<String, dynamic>{});
      }
      print('Subcollection added for: $universityName');
    } catch (e) {
      print('Error adding subcollection for university: $e');
    }
  }
}
