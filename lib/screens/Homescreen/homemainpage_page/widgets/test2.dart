import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search PDF',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String searchTerm = _searchController.text;
                searchPdf(
                    searchTerm); // Call searchPdf function with the entered searchTerm
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<DocumentSnapshot>> searchPdf(String pdfName) async {
  List<DocumentSnapshot> searchResults = [];

  // Reference to the root collection
  CollectionReference universitiesCollection =
      FirebaseFirestore.instance.collection('universities');

  // Perform the search recursively starting from the root collection
  await _searchInCollection(universitiesCollection, pdfName, searchResults);

  return searchResults;
}

Future<void> _searchInCollection(CollectionReference collection, String pdfName,
    List<DocumentSnapshot> searchResults) async {
  // Query documents in the current collection
  QuerySnapshot querySnapshot = await collection.get();

  // Check each document in the collection
  for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
    // Check if the current document has a field containing the PDF name
    // Check if the current document has a field containing the PDF name
    if (documentSnapshot.data() != null &&
        documentSnapshot.data()!.containsKey('pdfName') &&
        documentSnapshot.data()!['pdfName'] == pdfName) {
      searchResults.add(documentSnapshot);
    }

    // If the document has subcollections, recursively search them
    await _searchInSubcollections(
        documentSnapshot.reference, pdfName, searchResults);
  }
}

Future<void> _searchInSubcollections(DocumentReference documentReference,
    String pdfName, List<DocumentSnapshot> searchResults) async {
  // Get all subcollections of the current document
  QuerySnapshot subcollectionsSnapshot =
      await documentReference.listCollections();

  // Check each subcollection
  for (QueryDocumentSnapshot subcollectionSnapshot
      in subcollectionsSnapshot.docs) {
    // Perform the search recursively in the subcollection
    await _searchInCollection(
        subcollectionSnapshot.reference, pdfName, searchResults);
  }
}
