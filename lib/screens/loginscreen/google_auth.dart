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

      // Create new profile for the user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Actual sign-in
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to the home screen
      User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        // User is already registered, navigate to the home screen
        Navigator.pushNamed(context, AppRoutes.homescreen);
      } else {
        // User is not registered, navigate to the profile screen
        Navigator.pushNamed(context, AppRoutes.fillYourProfileScreen);
      }
    } catch (e) {
      // Handle errors, e.g., no network or Google login failure
      if (e is FirebaseAuthException) {
        // Show error dialog only if it's a Firebase Auth error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'Failed to sign in with Google. Please try again.'),
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
  }
}
