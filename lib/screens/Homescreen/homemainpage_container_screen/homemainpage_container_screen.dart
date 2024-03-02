import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/Homescreen/homemainpage_page/homemainpage_page.dart';
import 'package:edumike/screens/Homescreen/indoxmainpage_page/indoxmainpage_page.dart';
import 'package:edumike/screens/Homescreen/my_bookmark_page/my_bookmark_page.dart';
import 'package:edumike/screens/Homescreen/my_course_page/my_course_page.dart';
import 'package:edumike/screens/Homescreen/profiles_page/profiles_page.dart';
import 'package:edumike/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

class CardDataRepository {
  Future<Map<String, String?>?> getCardData(String userId) async {
    try {
      // Reference to the "carddata" collection under the user's ID
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)  // Use the provided userId parameter
              .collection('carddata')
              .doc(userId)  // Use the provided userId parameter
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
    } catch (e) {
      // Print an error message if an error occurs
      print('Error retrieving card data: $e');
      return null;
    }
  }
}

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
            body: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.homemainpagePage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar: _buildBottomBar(context)));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
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
        return MyCoursePage(university: university,degree: degree,course: course,semester: semester,);
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
