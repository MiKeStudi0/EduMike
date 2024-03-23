import 'package:edumike/screens/Homescreen/category_screen/category_screen.dart';
import 'package:edumike/theme/custom_text_style.dart';
import 'package:edumike/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/app_export.dart';

class CardDataRepository {
  Future<Map<String, String?>?> getCardData(String userId) async {
    try {
      // Reference to the "carddata" collection under the user's ID
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId) // Use the provided userId parameter
              .collection('carddata')
              .doc(userId) // Use the provided userId parameter
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

class testingfor extends StatefulWidget {
  @override
  _testingforState createState() => _testingforState();
}

class _testingforState extends State<testingfor> {
  // Define a list to store fetched data
  List<String> itemList = [];
  String selectedCategory = 'SYLLABUS';
  String? _selecteduniversity;
  String? _selecteddegree;
  String? _selectedcourse;
  String? _selectedsemester;

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
        Map<String, String?>? cardData =
            await CardDataRepository().getCardData(user.uid);

        if (cardData != null) {
          setState(() {
            // Store retrieved values in variables
            _selecteduniversity = cardData['university'];
            _selecteddegree = cardData['degree'];
            _selectedcourse = cardData['course'];
            _selectedsemester = cardData['semester'];
          });

          // Use the retrieved values in fetchDocumentData method
          fetchItemsFromFirebase(
              '/University/$_selecteduniversity/Refers/$_selecteddegree/Refers/$_selectedcourse/Refers/$_selectedsemester/Refers');
        }
      }
    } catch (e) {
      // Handle errors
      print('Error initializing data: $e');
    }
  }

  // Method to fetch items from Firebase
  Future<void> fetchItemsFromFirebase(String collection) async {
    try {
      // Access Firebase Firestore collection
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collection).get();
      List<String> docNames = [];

      // Extract data from the snapshot
      querySnapshot.docs.forEach((doc) {
        docNames.add(doc.id); // Add document ID to itemList
      });

      // Update the state with fetched items
      setState(() {
        itemList = docNames;
      });
      itemList.forEach((itemName) async {
        DocumentSnapshot<Map<String, dynamic>> courseDataSnapshot =
            await FirebaseFirestore.instance
                .collection(collection)
                .doc(itemName)
                .get();

        // Check if the document exists
        if (courseDataSnapshot.exists) {
          // Extract field values from the document data
          Map<String, dynamic> courseData = courseDataSnapshot.data()!;
          // Now you can use courseData for each item in itemList
          // For example, to access the course code and credit:
          String courseCode = courseData['courseCode'];
          String courseCredit = courseData['courseCredit'];
          // Do whatever you need with courseCode and courseCredit
        }
      });
    } catch (e) {
      // Handle errors
      print('Error fetching items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Items List'),
        // Add a back button to navigate to the home page
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: itemList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : buildItemListWidget(),
    );
  }

  Widget buildItemListWidget() {
    return Container(
      height: 340,
      width: 400,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: itemList.map((itemName) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                          university: _selecteduniversity,
                          degree: _selecteddegree,
                          course: _selectedcourse,
                          semester: _selectedsemester,
                          courseName: itemName,
                        )),
              );
              // Add your onTap logic here
              print('$itemName tapped');
            },
            child: SizedBox(
              height: 245.h,
              width: 290.v,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 245.h,
                    width: 290.v,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 134,
                        width: 280,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 15, right: 19),
                      //   child: SizedBox(
                      //     width: 245,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         SizedBox(
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(bottom: 1),
                      //             child: Text(course.category,
                      //                 style: CustomTextStyles
                      //                     .labelLargeMulishOrangeA700
                      //                     .copyWith(
                      //                         color: appTheme.orangeA700)),
                      //           ),
                      //         ),
                      //         // GestureDetector(
                      //         //   onTap: () {
                      //         //     _addToBookmarkCollection(course);
                      //         //   },
                      //         //   child: isBookmarked
                      //         //       ? CustomImageView(
                      //         //           imagePath: ImageConstant
                      //         //               .imgBookmarkPrimary, // Change to your bookmarked icon
                      //         //           height: 18,
                      //         //           width: 14,
                      //         //           color: Colors
                      //         //               .blue, // Change to your desired color
                      //         //         )
                      //         //       : CustomImageView(
                      //         //           imagePath: ImageConstant.imgBookmark,
                      //         //           height: 18,
                      //         //           width: 14,
                      //         //         ),
                      //         // ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(left: 14, right: 10),
                        child: Text(itemName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium),
                      ),
                      const SizedBox(height: 9),
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              margin: const EdgeInsets.only(top: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgSignal,
                                    height: 11,
                                    width: 12,
                                    margin: EdgeInsets.only(bottom: 2),
                                  ),
                                  Text('Credit',
                                      style: theme.textTheme.labelMedium!
                                          .copyWith(
                                              color: appTheme.blueGray90001)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text("|",
                                  style: CustomTextStyles.titleSmallBlack900
                                      .copyWith(color: appTheme.black900)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 3),
                              child: Text('course',
                                  style: theme.textTheme.labelMedium!
                                      .copyWith(color: appTheme.blueGray90001)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
