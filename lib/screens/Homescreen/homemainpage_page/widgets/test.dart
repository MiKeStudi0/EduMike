import 'package:edumike/screens/Homescreen/modules_screen/syllabus.dart';
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

class CourseListBlock extends StatefulWidget {
  @override
  _CourseListBlockState createState() => _CourseListBlockState();
}

class _CourseListBlockState extends State<CourseListBlock> {
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

    return SizedBox(
      height: 340.h,
      width: 400.v,
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
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                final course = filteredCourses[index];
                return _buildCourseList(context, course, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseList(BuildContext context, Course course, int index) {
    bool isBookmarked = bookmarkedCourses.contains(course.courseCode);
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
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 19),
                  child: SizedBox(
                    width: 245,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 1),
                            child: Text(course.category,
                                style: CustomTextStyles
                                    .labelLargeMulishOrangeA700
                                    .copyWith(color: appTheme.orangeA700)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _addToBookmarkCollection(course);
                          },
                          child: isBookmarked
                              ? CustomImageView(
                                  imagePath: ImageConstant
                                      .imgBookmarkPrimary, // Change to your bookmarked icon
                                  height: 18,
                                  width: 14,
                                  color: Colors
                                      .blue, // Change to your desired color
                                )
                              : CustomImageView(
                                  imagePath: ImageConstant.imgBookmark,
                                  height: 18,
                                  width: 14,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 10),
                  child: Text(course.courseName,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgSignal,
                              height: 11,
                              width: 12,
                              margin: EdgeInsets.only(bottom: 2),
                            ),
                            Text(course.courseCredit,
                                style: theme.textTheme.labelMedium!
                                    .copyWith(color: appTheme.blueGray90001)),
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
                        child: Text(course.courseCode,
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
  }
}
