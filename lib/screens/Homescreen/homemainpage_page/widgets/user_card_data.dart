import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CardDataRepository {
  Future<Map<String, String?>?> getCardData() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Access the "carddata" document under the user's ID
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('carddata')
                .doc(user.uid)
                .get();

        // Check if the document exists
        if (snapshot.exists) {
          // Extract field values from the document data
          String? university = snapshot.data()?['university'];
          String? degree = snapshot.data()?['degree'];
          String? course = snapshot.data()?['course'];
          String? semester = snapshot.data()?['semester'];

          // Return the card data as a map
          return {
            'university': university,
            'degree': degree,
            'course': course,
            'semester': semester,
          };
        } else {
          // Return null if the document doesn't exist
          return null;
        }
      } else {
        // Handle case when user is not authenticated
        throw 'User not authenticated';
      }
    } catch (e) {
      // Propagate the error for handling in the calling code
      throw 'Error retrieving card data: $e';
    }
  }
}
