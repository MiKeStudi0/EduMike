import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/Homescreen/homemainpage_page/homemainpage_page.dart';
import 'package:edumike/screens/Homescreen/homemainpage_page/widgets/newcourse.dart';
import 'package:edumike/screens/Homescreen/indoxmainpage_page/indoxmainpage_page.dart';
import 'package:edumike/screens/Homescreen/my_bookmark_page/my_bookmark_page.dart';
import 'package:edumike/screens/Homescreen/my_course_page/my_course_page.dart';
import 'package:edumike/screens/Homescreen/profiles_page/profiles_page.dart';
import 'package:edumike/widgets/custom_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
class HomemainpageContainerScreen extends StatefulWidget {
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

  @override
  State<HomemainpageContainerScreen> createState() => _HomemainpageContainerScreenState();
}

class _HomemainpageContainerScreenState extends State<HomemainpageContainerScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

 



  String? _selecteduniversity;

  String? _selecteddegree;

  String? _selectedcourse;

  String? _selectedsemester;

  List<String> bookmarkedCourses = [];

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  

 Future<void> initializeData() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Use the user's ID dynamically for fetching card data
        Map<String, String?>? cardData = await CardDataRepository().getCardData(user.uid);

        if (cardData != null) {
          setState(() {
            // Store retrieved values in variables
            _selecteduniversity = cardData['university'];
            _selecteddegree = cardData['degree'];
            _selectedcourse = cardData['course'];
            _selectedsemester = cardData['semester'];
          });

          // Use the retrieved values in fetchDocumentData method
          fetchDocumentData(
              '/University/$_selecteduniversity/Refers/$_selecteddegree/Refers/$_selectedcourse/Refers/$_selectedsemester/Refers');
        }
      }
    } catch (e) {
      // Handle errors
      print('Error initializing data: $e');
    }
  }

  Future<Map<String, String?>?> getCardData() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the "carddata" collection
       
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
          String? _selecteduniversity = snapshot.data()?['university'];
          String? _selecteddegree = snapshot.data()?['degree'];
          String? _selectedcourse = snapshot.data()?['course'];
          String? _selectedsemester = snapshot.data()?['semester'];

          // Return the card data as a map
          return {
            'university': _selecteduniversity,
            'degree': _selecteddegree,
            'course': _selectedcourse,
            'semester': _selectedsemester,
          };
        } else {
          // Return null if the document doesn't exist
          return null;
        }
      } else {
        // Handle case when user is not authenticated
        print('User not authenticated');
        return null;
      }
    } catch (e) {
      // Print an error message if an error occurs
      print('Error retrieving card data: $e');
      return null;
    }
  }

Future<void> fetchDocumentData(String collectionPath) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(collectionPath).get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = {
        'id': doc.id,
        'courseName': doc.get('courseName'),
        'courseCode': doc.get('courseCode'),
        'courseCredit': doc.get('courseCredit'),
        'category': 'DefaultCategory',
      };

      QuerySnapshot subcollectionSnapshot = await doc.reference.collection('Refers').get();
      if (subcollectionSnapshot.docs.isNotEmpty) {
        QueryDocumentSnapshot subDoc = subcollectionSnapshot.docs.first;
        data['category'] = subDoc.get('category');
      }

      Course course = Course(
        courseName: doc.get('courseName'),
        category: data['category'],
        courseCode: doc.get('courseCode'),
        courseCredit: doc.get('courseCredit'),
        selectedDocumentId: doc.id,
      );

      courseList.add(course);

      String nestedCollectionPath = '$collectionPath/${doc.id}/Refers';
      await fetchDocumentData(nestedCollectionPath);
      print('Data from $collectionPath: $data');
    }

    setState(() {});
  } catch (e, stackTrace) {
    print('Error getting document data: $e\n$stackTrace');
  }
}

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
        return MyCoursePage(university: _selecteduniversity,degree: _selecteddegree,course: _selectedcourse,semester: _selectedsemester,);
      case AppRoutes.myBookmarkPage:
        return const  MyBookmarkPage();
      case AppRoutes.indoxmainpagePage:
        return const IndoxmainpagePage();
      case AppRoutes.profilesPage:
        return ProfilesPage();
      default:
        return DefaultWidget();
    }
  }
}
