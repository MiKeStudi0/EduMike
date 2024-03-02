import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/Homescreen/homemainpage_page/homemainpage_page.dart';
import 'package:edumike/screens/Homescreen/indoxmainpage_page/indoxmainpage_page.dart';
import 'package:edumike/screens/Homescreen/my_bookmark_page/my_bookmark_page.dart';
import 'package:edumike/screens/Homescreen/my_course_page/my_course_page.dart';
import 'package:edumike/screens/Homescreen/profiles_page/profiles_page.dart';
import 'package:edumike/widgets/custom_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String universityField = '';
String degreeField = '';
String courseField = '';
String semesterField = '';

// ignore_for_file: must_be_immutable
class HomemainpageContainerScreen extends StatelessWidget {
  final String? university;
  final String? degree;
  final String? course;
  final String? semester;

  HomemainpageContainerScreen({
    this.university,
    this.degree,
    this.course,
    this.semester,
  });

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: FutureBuilder<DocumentSnapshot>(
          future: getDocumentData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              universityField = snapshot.data!['university'];
              degreeField = snapshot.data!['degree'];
              courseField = snapshot.data!['course'];
              semesterField = snapshot.data!['semester'];

              return Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.homemainpagePage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                  pageBuilder: (ctx, ani, ani1) =>
                      getCurrentPage(routeSetting.name!),
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            }
          },
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  Future<DocumentSnapshot> getDocumentData() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Reference to the user's document in Firestore
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('carddata')
          .doc(user.uid)
          .get();
      return documentSnapshot;
    } else {
      throw 'User not authenticated';
    }
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homemainpagePage;
      case BottomBarEnum.Mycourses:
        return AppRoutes.myCoursePage;
      case BottomBarEnum.Indox:
        return AppRoutes.indoxmainpagePage;
      case BottomBarEnum.Bookmark:
        return AppRoutes.myBookmarkPage;
      case BottomBarEnum.Profile:
        return AppRoutes.profilesPage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homemainpagePage:
        return HomemainpagePage();
      case AppRoutes.myCoursePage:
        return MyCoursePage(
          university: universityField,
          degree: degreeField,
          course: courseField,
          semester: semesterField,
        );
      case AppRoutes.myBookmarkPage:
        return MyBookmarkPage();
      case AppRoutes.indoxmainpagePage:
        return IndoxmainpagePage();
      case AppRoutes.profilesPage:
        return ProfilesPage();
      default:
        return DefaultWidget();
    }
  }
}
