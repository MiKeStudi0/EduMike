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
            child: DropdownButton<String>(
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
                    width: MediaQuery.of(context).size.width -
                        40, // Adjust the width as needed
                    child: Text(
                      document.id,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
