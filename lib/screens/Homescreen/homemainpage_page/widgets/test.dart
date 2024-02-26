import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentIdsScreen extends StatefulWidget {
  @override
  _DocumentIdsScreenState createState() => _DocumentIdsScreenState();
}

class _DocumentIdsScreenState extends State<DocumentIdsScreen> {
  List<Map<String, dynamic>> documentData = [];

  @override
  void initState() {
    super.initState();
    fetchDocumentData('/University/A.P.J. Abdul Kalam Technological University/Refers/B.Tech/Refers/Computer Science and Engineering/Refers/S1/Refers');
  }

  Future<void> fetchDocumentData(String collectionPath) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collectionPath)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = {
          'id': doc.id,
          // Replace 'field1', 'field2', etc. with the actual field names
          'courseName': doc.get('courseName'),
          'courseCode': doc.get('courseCode'),
          // Add more fields as needed
        };

        documentData.add(data);

        // Assuming $documentIds is a field within the document, adapt accordingly
        String nestedCollectionPath = '$collectionPath/${doc.id}/Refers';
        await fetchDocumentData(nestedCollectionPath);
      }

      setState(() {
        // Update the state after adding all document data
        documentData = List.from(documentData);
      });
    } catch (e) {
      print('Error getting document data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Data'),
      ),
      body: ListView.builder(
        itemCount: documentData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('ID: ${documentData[index]['id']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('courseName: ${documentData[index]['courseName']}'),
                Text('courseCode: ${documentData[index]['courseCode']}'),
                // Add more fields as needed
              ],
            ),
          );
        },
      ),
    );
  }
}
