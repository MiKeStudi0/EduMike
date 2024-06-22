import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/Homescreen/homemainpage_container_screen/homemainpage_container_screen.dart';
import 'package:edumike/widgets/custom_drop_down_home.dart';
import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
import 'package:edumike/widgets/custom_outlined_button_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AddUniversityCardScreen extends StatefulWidget {
  const AddUniversityCardScreen({super.key});

  @override
  State<AddUniversityCardScreen> createState() =>
      _AddUniversityCardScreenState();
}

class _AddUniversityCardScreenState extends State<AddUniversityCardScreen> {
  String? _selectedUniversityId;
  String? _selectedDegreeId;
  String? _selectedCourseId;
  String? _selectedSemesterId;
  List<String> universityList = [];
  List<String> degreeList = [];
  List<String> courseList = [];
  List<String> semesterList = [];

  @override
  void initState() {
    super.initState();
    fetchUniversityNames();
  }

  Future<void> fetchUniversityNames() async {
    try {
      degreeList.clear();
      courseList.clear();
      semesterList.clear();
      // Access the "university" collection
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('University').get();
      // Extract the document names and add them to the dropdownItemList
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        universityList.add(documentSnapshot.id);
      }
      // Update the state to reflect the changes
      setState(() {});
    } catch (e) {
      print('Error fetching university names: $e');
    }
  }

  Future<void> fetchDegreeNames() async {
    try {
      degreeList.clear();
      courseList.clear();
      semesterList.clear();
      // Access the "university" collection
      QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
          .collection('/University/$_selectedUniversityId/Refers')
          .get();
      // Extract the document names and add them to the dropdownItemList
      for (QueryDocumentSnapshot documentSnapshot2 in querySnapshot2.docs) {
        degreeList.add(documentSnapshot2.id);
      }
      // Update the state to reflect the changes
      setState(() {});
    } catch (e) {
      print('Error fetching university names: $e');
    }
  }

  Future<void> fetchCourseNames() async {
    try {
      courseList.clear();
      semesterList.clear();
      // Access the "university" collection
      QuerySnapshot querySnapshot3 = await FirebaseFirestore.instance
          .collection(
              '/University/$_selectedUniversityId/Refers/$_selectedDegreeId/Refers')
          .get();
      // Extract the document names and add them to the dropdownItemList
      for (QueryDocumentSnapshot documentSnapshot3 in querySnapshot3.docs) {
        courseList.add(documentSnapshot3.id);
      }
      // Update the state to reflect the changes
      setState(() {});
    } catch (e) {
      print('Error fetching university names: $e');
    }
  }

  Future<void> fetchSemesterNames() async {
    try {
      semesterList.clear();
      // Access the "university" collection
      QuerySnapshot querySnapshot4 = await FirebaseFirestore.instance
          .collection(
              '/University/$_selectedUniversityId/Refers/$_selectedDegreeId/Refers/$_selectedCourseId/Refers')
          .get();
      // Extract the document names and add them to the dropdownItemList
      for (QueryDocumentSnapshot documentSnapshot4 in querySnapshot4.docs) {
        semesterList.add(documentSnapshot4.id);
      }
      // Update the state to reflect the changes
      setState(() {});
    } catch (e) {
      print('Error fetching university names: $e');
    }
  }

  void uploadCardData() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the "carddata" collection
        CollectionReference cardDataCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('carddata');

        // Add a new document to the "carddata" collection with the user's ID
        await cardDataCollection.doc(user.uid).set({
          'university': _selectedUniversityId,
          'degree': _selectedDegreeId,
          'course': _selectedCourseId,
          'semester': _selectedSemesterId,
        });

        // Print a message indicating successful upload
        print('Card data uploaded successfully');
      } else {
        // Handle case when user is not authenticated
        print('User not authenticated');
      }
    } catch (e) {
      // Print an error message if an error occurs
      print('Error uploading card data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 28.h, vertical: 25.v),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 101.h),
                          child: Text("Add Your Card",
                              style: theme.textTheme.titleLarge)),
                      SizedBox(height: 7.v),
                      _buildUniversity(context),
                      SizedBox(height: 13.v),
                      _buildDegree(context),
                      SizedBox(height: 20.v),
                      _buildCourse(context),
                      SizedBox(height: 25.v),
                      _buildSemester(context),
                      SizedBox(height: 28.v),
                      _buildCancel(context),
                      SizedBox(height: 5.v)
                    ]))));
  }

  /// Section Widget
  Widget _buildUniversity(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.h, right: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("University",
              style: CustomTextStyles.titleMediumMontserratBluegray900),
          SizedBox(height: 6.v),
          CustomDropDown(
              hintText: "Select  University",
              items: universityList,
              onChanged: (String? value) {
                setState(() {
                  degreeList = [];
                  courseList = [];
                  semesterList = [];
                  _selectedUniversityId = value;
                  fetchDegreeNames();
                });
              })
        ]));
  }

  /// Section Widget
  Widget _buildDegree(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.h, right: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Degree",
              style: CustomTextStyles.titleMediumMontserratBluegray900),
          SizedBox(height: 6.v),
          CustomDropDown(
              hintText: "Select Degree",
              items: degreeList,
              onChanged: (String? value) {
                setState(() {
                  courseList = [];
                  semesterList = [];
                  _selectedDegreeId = value;
                  fetchCourseNames();
                });
              })
        ]));
  }

  /// Section Widget
  Widget _buildCourse(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.h, right: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Course",
              style: CustomTextStyles.titleMediumMontserratBluegray900),
          SizedBox(height: 7.v),
          CustomDropDown(
              hintText: "Select Course",
              items: courseList,
              onChanged: (String? value) {
                setState(() {
                  semesterList = [];
                  _selectedCourseId = value;
                  fetchSemesterNames();
                });
              })
        ]));
  }

  /// Section Widget
  Widget _buildSemester(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.h, right: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Semester",
              style: CustomTextStyles.titleMediumMontserratBluegray900),
          SizedBox(height: 7.v),
          CustomDropDown(
              hintText: "Select Semester",
              items: semesterList,
              onChanged: (String? value) {
                setState(() {
                  _selectedSemesterId = value;
                });
              })
        ]));
  }

  /// Section Widget
  Widget _buildCancel(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 13.h),
        child: Row(children: [
          CustomOutlinedButton(
              width: 140.h,
              text: "Cancel",
              onPressed: () {
                onTapCancel(context);
              }),
          CustomElevatedButton(
              width: 206.h,
              text: "Yes, Change",
              margin: EdgeInsets.only(left: 13.h),
              onPressed: () {
                onTapYesChange(context);
              })
        ]));
  }

  /// Navigates to the homemainpageContainerScreen when the action is triggered.
  onTapCancel(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the homemainpageContainerScreen when the action is triggered.
  // onTapYesChange(BuildContext context) {
  //   uploadCardData();
  //   Navigator.pop(context);
  // }
  onTapYesChange(BuildContext context) {
    uploadCardData();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500), // Adjust as needed
        pageBuilder: (_, __, ___) => const HomemainpageContainerScreen(),
        transitionsBuilder: (_, animation, __, child) {
          // Apply a fade transition
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
