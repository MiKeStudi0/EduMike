import 'package:edumike/screens/Homescreen/modules_screen/syllabus.dart';
import 'package:edumike/screens/Homescreen/remove_bookmark_screen/remove_bookmark_screen.dart';
import 'package:edumike/widgets/custom_search_view_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/core/app_export.dart';

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

class Course {
  final String courseName;
  final String category;
  final String courseCode;
  final String courseCredit;
  final String selectedDocumentId;

  Course({
    required this.courseName,
    required this.category,
    required this.courseCode,
    required this.courseCredit,
    required this.selectedDocumentId,
  });
}

class SearchCourse extends StatefulWidget {
  final String university;
  final String degree;
  final String course;
  final String semester;

  const SearchCourse({
    required this.university,
    required this.degree,
    required this.course,
    required this.semester,
  });
  @override
  _SearchCourseState createState() => _SearchCourseState();
}

class _SearchCourseState extends State<SearchCourse> {
    TextEditingController searchController = TextEditingController();

  List<Course> courseList = [];
  final List<String> categories = [
    'Syllabus',
    'Notes',
    'Text Book',
    'Question Paper',
    'Question Bank',
    'Lab Manual',
    'Others'
  ];
  String selectedCategory = 'Syllabus';
  String? _selecteduniversity;
  String? _selecteddegree;
  String? _selectedcourse;
  String? _selectedsemester;
  List<String> bookmarkedCourses = [];
  @override
  void initState() {
    super.initState();
    initializeData();
    loadBookmarkedCourses();
  }

  void _addToBookmarkCollection(Course course) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the user's bookmarks subcollection
        CollectionReference<Map<String, dynamic>> userBookmarksCollection =
            FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('bookmarks');

        // Check if a document with the same data already exists
        QuerySnapshot<Map<String, dynamic>> existingDocs =
            await userBookmarksCollection
                .where('courseCode', isEqualTo: course.courseCode)
                .where('university', isEqualTo: _selecteduniversity)
                .where('degree', isEqualTo: _selecteddegree)
                .where('course', isEqualTo: _selectedcourse)
                .where('semester', isEqualTo: _selectedsemester)
                .get();

        if (existingDocs.docs.isEmpty) {
          // Add the data to the user's bookmarks subcollection
          await userBookmarksCollection.add({
            'category': course.category,
            'courseName': course.courseName,
            'courseCode': course.courseCode,
            'courseCredit': course.courseCredit,
            'university': _selecteduniversity,
            'degree': _selecteddegree,
            'course': _selectedcourse,
            'semester': _selectedsemester,
          });

          // Optionally show a confirmation message or perform any other action
          print('Bookmark added successfully!');
          // Update the list of bookmarked courses
          loadBookmarkedCourses();
        } else {
          // Bookmark already exists, delete it
          String documentId = existingDocs.docs.first.id;
          await userBookmarksCollection.doc(documentId).delete();
          // Optionally show a confirmation message or perform any other action
          print('Bookmark removed successfully!');
          // Update the list of bookmarked courses
          loadBookmarkedCourses();
        }
      }
    } catch (e) {
      // Handle errors
      print('Error updating bookmark: $e');
    }
  }

  void loadBookmarkedCourses() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the user's bookmarks subcollection
        CollectionReference<Map<String, dynamic>> userBookmarksCollection =
            FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('bookmarks');

        // Get the list of bookmarked courses
        QuerySnapshot<Map<String, dynamic>> snapshot =
            await userBookmarksCollection.get();

        setState(() {
          bookmarkedCourses =
              snapshot.docs.map((doc) => doc['courseCode'] as String).toList();
          // Explicitly cast the result to List<String>
        });
      }
    } catch (e) {
      // Handle errors
      print('Error loading bookmarked courses: $e');
    }
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
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collectionPath).get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = {
        'id': doc.id,
        'courseName': doc.get('courseName'),
        'courseCode': doc.get('courseCode'),
        'courseCredit': doc.get('courseCredit'),
        'category': 'DefaultCategory',
      };

      // Fetch the first level of subcollection
      QuerySnapshot subcollectionSnapshot =
          await doc.reference.collection('Refers').get();
      
      // Iterate over all documents in the first level of subcollection
      for (QueryDocumentSnapshot subDoc in subcollectionSnapshot.docs) {
        data['category'] = subDoc.get('category');
        
        // Fetch the second level of subcollection
        QuerySnapshot nestedSubcollectionSnapshot =
            await subDoc.reference.collection('Refers').get();

        // Iterate over all documents in the second level of subcollection
        for (QueryDocumentSnapshot nestedSubDoc in nestedSubcollectionSnapshot.docs) {
          // You can handle data from the second level of subcollection here
          // For example:
           data['pdfUrl'] = nestedSubDoc.get('pdfUrl');
        }

        Course course = Course(
          courseName: doc.get('courseName'),
          category: data['category'],
          courseCode: doc.get('courseCode'),
          courseCredit: doc.get('courseCredit'),

          selectedDocumentId: doc.id,
        );

        courseList.add(course);

        // String nestedCollectionPath = '$collectionPath/${doc.id}/Refers';
        // await fetchDocumentData(nestedCollectionPath);
       // print('Data from $collectionPath: $data');
      }
    }

    setState(() {});
  } catch (e, stackTrace) {
    print('Error getting document data: $e\n$stackTrace');
  }
}


  @override
  Widget build(BuildContext context) {
    final filteredCourses = courseList.where((course) {
      return selectedCategory.isEmpty || selectedCategory == course.category;
    }).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            
            children: [
               Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34.h),
                        child: CustomSearchView(
                          
                            controller: searchController,
                            hintText: "Search for..")),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  height: 796.h,
                  width: 450.v,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: categories
                              .map(
                                (category) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FilterChip(
                                    label: Text(category),
                                    selected: selectedCategory == category.toUpperCase(),
                                    onSelected: (selected) {
                                      setState(() {
                                        selectedCategory = selected ? category : 'Syllabus';
                                      });
                                    },
                                   selectedColor: selectedCategory.isEmpty
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.primary,
                                    labelStyle: TextStyle(
                                      color: selectedCategory == category
                                          ? Color.fromARGB(255, 0, 94, 255)
                                          : null,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(height: 1),
                          scrollDirection: Axis.vertical,
                          itemCount: filteredCourses.length,
                          itemBuilder: (context, index) {
                            final course = filteredCourses[index];
                            return _buildCourseList(context, course, index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseList(BuildContext context, Course course, int index) {
    return GestureDetector(
      onTap: () {
        if (selectedCategory == 'Syllabus') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Syllabus(
                university: _selecteduniversity!,
                degree: _selecteddegree!,
                course: _selectedcourse!,
                semester: _selectedsemester!,
                courseName: course.courseName,
                category: course.category,
              ),
            ),
          );
        }
      },
      child: Container(
      margin: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 20.v),
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
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage,
            height: 130.adaptSize,
            width: 130.adaptSize,
            radius: BorderRadius.horizontal(
              left: Radius.circular(20.h),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 14.h, top: 5.v, bottom: 13.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 195.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          course.category,
                          style: CustomTextStyles.labelLargeMulishOrangeA700,
                        ),
                        SizedBox(
                          height: 16.v,
                          width: 12.h,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgBookmarkPrimary,
                                height: 16.v,
                                width: 12.h,
                                alignment: Alignment.center,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RemoveBookmarkScreen(),
                                    ),
                                  );
                                },
                              ),
                              // CustomImageView(
                              //   imagePath: ImageConstant.imgBookmarkPrimary,
                              //   height: 16.v,
                              //   width: 12.h,
                              //   alignment: Alignment.center,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    course.courseName,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.v),
                  Text(
                    course.courseCode,
                    style: theme.textTheme.titleSmall,
                  ),
                  SizedBox(height: 5.v),
                  Row(
                    children: [
                      Container(
                        width: 32.h,
                        margin: EdgeInsets.only(top: 3.v),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgSignal,
                              height: 11.v,
                              width: 12.h,
                              margin: EdgeInsets.only(bottom: 2.v),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                "${course.courseCredit}",
                                style: theme.textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.h, top: 3.v),
                        child: Text(
                          "Credit",
                          style: theme.textTheme.labelMedium,
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 16.h, top: 3.v),
                      //   child: Text(
                      //     bookmark.,
                      //     style: theme.textTheme.labelMedium,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
