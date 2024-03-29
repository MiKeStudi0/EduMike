import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Begin sign-in
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        // Google sign-in canceled
        return;
      }

      // Obtain auth details
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in with credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if user is already registered and profile is filled
      User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        // Check if user's profile is filled
        bool isProfileFilled = await checkProfileFilled(firebaseUser.uid);
        if (isProfileFilled) {
          // User is already registered and profile is filled, navigate to the home screen
          Navigator.pushReplacementNamed(
              context, AppRoutes.homemainpageContainerScreen);
        } else {
          // User is registered but profile is not filled, navigate to the fill your profile screen
          Navigator.pushNamed(context, AppRoutes.fillYourProfileScreen);
        }
      } else {
        // User is not registered, navigate to the fill your profile screen
        Navigator.pushNamed(context, AppRoutes.fillYourProfileScreen);
      }
    } catch (e) {
      // Handle errors
      print('Error signing in with Google: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Failed to sign in with Google. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<bool> checkProfileFilled(String userId) async {
    try {
      // Get a reference to the user document
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .get();

      // Check if the document exists
      return userSnapshot.exists;
    } catch (e) {
      // Handle any errors
      print('Error checking if profile is filled: $e');
      return false; // Return false in case of an error
    }
  }
}
