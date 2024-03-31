// import 'package:edumike/screens/Homescreen/modules_screen/syllabus.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:edumike/core/app_export.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
//    part 'coursebuilder.g.dart';

// class CardDataRepository {
//   Future<Map<String, String?>?> getCardData(String userId) async {
//     try {
//       // Reference to the "carddata" collection under the user's ID
//       DocumentSnapshot<Map<String, dynamic>> snapshot =
//           await FirebaseFirestore.instance
//               .collection('users')
//               .doc(userId) // Use the provided userId parameter
//               .collection('carddata')
//               .doc(userId) // Use the provided userId parameter
//               .get();

//       // Check if the document exists
//       if (snapshot.exists) {
//         // Extract field values from the document data
//         String? university1 = snapshot.data()?['university'];
//         String? degree1 = snapshot.data()?['degree'];
//         String? course1 = snapshot.data()?['course'];
//         String? semester1 = snapshot.data()?['semester'];

//         // Return the card data as a map
//         return {
//           'university': university1,
//           'degree': degree1,
//           'course': course1,
//           'semester': semester1,
//         };
//       } else {
//         // Return null if the document doesn't exist
//         return null;
//       }
//     } catch (e) {
//       // Print an error message if an error occurs
//       print('Error retrieving card data: $e');
//       return null;
//     }
//   }
// }

//  @HiveType(typeId: 1)
//   class Course {
//   @HiveField(0)
//   final String courseName;
//   @HiveField(1)
//   final String category;
//   @HiveField(2)
//   final String courseCode;
//   @HiveField(3)
//   final String courseCredit;
//   @HiveField(4)
//   final String selectedDocumentId;

//   Course({
//     required this.courseName,
//     required this.category,
//     required this.courseCode,
//     required this.courseCredit,
//     required this.selectedDocumentId,
//   });
// }

// class courseBuilder extends StatefulWidget {
//   @override
//   _courseBuilderState createState() => _courseBuilderState();
// }

// class _courseBuilderState extends State<courseBuilder> {
//     // Initialize Hive box
 



//  late Box<Course>? _courseBox; // Make _courseBox nullable

//   @override
//   void initState() {
//     super.initState();
//     initializeData();
//     initializeHive().then((_) {
//       loadCoursesFromHive();
//     });
//   }

// Future<void> initializeHive() async {
//   final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
//   Hive.init(appDocumentDir.path);
//   if (!Hive.isAdapterRegistered(1)) { // Check if the adapter is not already registered
//     Hive.registerAdapter(CourseAdapter());
//   }
//   _courseBox = await Hive.openBox<Course>('courses');
// }



//   void loadCoursesFromHive() {
//     if (_courseBox == null) {
//       // Ensure _courseBox is initialized before accessing it
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     courseList = _courseBox!.values.toList(); // Use _courseBox! to access non-nullable value

//     setState(() {
//       isLoading = false;
//     });
//   }


//   bool isLoading = true;
//   List<Course> courseList = [];
//   final List<String> categories = [
//     'Syllabus',
//     'Notes',
//     'Text Book',
//     'Question Paper',
//     'Question Bank',
//     'Lab Manual',
//     'Others'
//   ];
//   String selectedCategory = 'Syllabus';
//   String? _selecteduniversity;
//   String? _selecteddegree;
//   String? _selectedcourse;
//   String? _selectedsemester;
//   List<String> bookmarkedCourses = [];
 

//   void _addToBookmarkCollection(Course course) async {
//     try {
//       // Get the current user
//       User? user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         // Reference to the user's bookmarks subcollection
//         CollectionReference<Map<String, dynamic>> userBookmarksCollection =
//             FirebaseFirestore.instance
//                 .collection('users')
//                 .doc(user.uid)
//                 .collection('bookmarks');

//         // Check if a document with the same data already exists
//         QuerySnapshot<Map<String, dynamic>> existingDocs =
//             await userBookmarksCollection
//                 .where('courseCode', isEqualTo: course.courseCode)
//                 .where('university', isEqualTo: _selecteduniversity)
//                 .where('degree', isEqualTo: _selecteddegree)
//                 .where('course', isEqualTo: _selectedcourse)
//                 .where('semester', isEqualTo: _selectedsemester)
//                 .where('category', isEqualTo: course.category)
//                 .get();

//         if (existingDocs.docs.isEmpty) {
//           // Add the data to the user's bookmarks subcollection
//           await userBookmarksCollection.add({
//             'category': course.category,
//             'courseName': course.courseName,
//             'courseCode': course.courseCode,
//             'courseCredit': course.courseCredit,
//             'university': _selecteduniversity,
//             'degree': _selecteddegree,
//             'course': _selectedcourse,
//             'semester': _selectedsemester,
//           });

//           // Optionally show a confirmation message or perform any other action
//           print('Bookmark added successfully!');
//           // Update the list of bookmarked courses
//           loadBookmarkedCourses();
//         } else {
//           // Bookmark already exists, delete it
//           String documentId = existingDocs.docs.first.id;
//           await userBookmarksCollection.doc(documentId).delete();
//           // Optionally show a confirmation message or perform any other action
//           print('Bookmark removed successfully!');
//           // Update the list of bookmarked courses
//           loadBookmarkedCourses();
//         }
//       }
//     } catch (e) {
//       // Handle errors
//       print('Error updating bookmark: $e');
//     }
//   }
  

//   void loadBookmarkedCourses() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         // Reference to the user's bookmarks subcollection
//         CollectionReference<Map<String, dynamic>> userBookmarksCollection =
//             FirebaseFirestore.instance
//                 .collection('users')
//                 .doc(user.uid)
//                 .collection('bookmarks');

//         // Get the list of bookmarked courses
//         QuerySnapshot<Map<String, dynamic>> snapshot =
//             await userBookmarksCollection.get();

//         setState(() {
//           bookmarkedCourses = snapshot.docs
//               .map((doc) => '${doc['courseCode'] + doc['category']}')
//               .toList();
//           // Explicitly cast the result to List<String>
//         });
//       }
//     } catch (e) {
//       // Handle errors
//       print('Error loading bookmarked courses: $e');
//     }
//   }

//   Future<void> initializeData() async {
//     try {
//       // Get the current user
//       User? user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         setState(() {
//           isLoading = true; // Set isLoading to true before fetching data
//         });
//         // Use the user's ID dynamically for fetching card data
//         Map<String, String?>? cardData =
//             await CardDataRepository().getCardData(user.uid);

//         if (cardData != null) {
//           setState(() {
//             // Store retrieved values in variables
//             _selecteduniversity = cardData['university'];
//             _selecteddegree = cardData['degree'];
//             _selectedcourse = cardData['course'];
//             _selectedsemester = cardData['semester'];
//           });

//           // Use the retrieved values in fetchDocumentData method
//           fetchDocumentData(
//               '/University/$_selecteduniversity/Refers/$_selecteddegree/Refers/$_selectedcourse/Refers/$_selectedsemester/Refers');
//         }
//       }
//     } catch (e) {
//       // Handle errors
//       print('Error initializing data: $e');
//     }
//   }

//   Future<void> fetchDocumentData(String collectionPath) async {
//     try {

//        if (_courseBox == null) {
//       // Handle the case where _courseBox is not initialized yet
//       return;
//     }
//       QuerySnapshot querySnapshot =
//           await FirebaseFirestore.instance.collection(collectionPath).get();

//       for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//         Map<String, dynamic> data = {
//           'id': doc.id,
//           'courseName': doc.get('courseName'),
//           'courseCode': doc.get('courseCode'),
//           'courseCredit': doc.get('courseCredit'),
//           'category': 'DefaultCategory',
//         };

//         // Fetch the first level of subcollection
//         QuerySnapshot subcollectionSnapshot =
//             await doc.reference.collection('Refers').get();

//         // Iterate over all documents in the first level of subcollection
//         for (QueryDocumentSnapshot subDoc in subcollectionSnapshot.docs) {
//           data['category'] = subDoc.get('category');

//           // Fetch the second level of subcollection
//           QuerySnapshot nestedSubcollectionSnapshot =
//               await subDoc.reference.collection('Refers').get();

//           // Iterate over all documents in the second level of subcollection
//           for (QueryDocumentSnapshot nestedSubDoc
//               in nestedSubcollectionSnapshot.docs) {
//             // You can handle data from the second level of subcollection here
//             // For example:
//             data['pdfUrl'] = nestedSubDoc.get('pdfUrl');
//           }

//           Course course = Course(
//             courseName: doc.get('courseName'),
//             category: data['category'],
//             courseCode: doc.get('courseCode'),
//             courseCredit: doc.get('courseCredit'),
//             selectedDocumentId: doc.id,
//           );

          
//           // Add course to Hive box
//           _courseBox!.add(course);

//           // String nestedCollectionPath = '$collectionPath/${doc.id}/Refers';
//           // await fetchDocumentData(nestedCollectionPath);
//           // print('Data from $collectionPath: $data');
//         }
//       }

//       setState(() {});
//       // Set isLoading to false to stop the shimmer effect
//       // Set isLoading to false after data retrieval is complete
//       setState(() {
//         isLoading = false;
//       });
//     } catch (e, stackTrace) {
//       print('Error getting document data: $e\n$stackTrace');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredCourses = courseList.where((course) {
//       return selectedCategory.isEmpty || selectedCategory == course.category;
//     }).toList();

//     if (isLoading) {
//       return _buildLoading(); // Show shimmer effect while loading
//     } else {
//       return SizedBox(
//         height: 340.h,
//         //width: 415.v,
//         child: Column(
//           children: [
//             Container(
//               height: 50.h,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: categories
//                     .map(
//                       (category) => Padding(
//                         padding: const EdgeInsets.only(left: 5.0, bottom: 10),
//                         child: FilterChip(
//                           label: Text(category),
//                           selected: selectedCategory == category.toUpperCase(),
//                           onSelected: (selected) {
//                             setState(() {
//                               selectedCategory =
//                                   selected ? category : 'Syllabus';
//                             });
//                           },
//                           selectedColor: selectedCategory.isEmpty
//                               ? theme.colorScheme.primary
//                               : theme.colorScheme.primary,
//                           labelStyle: TextStyle(
//                             color: selectedCategory == category
//                                 ? Color.fromARGB(255, 0, 94, 255)
//                                 : null,
//                           ),
//                         ),
//                       ),
//                     )
//                     .toList(),
//               ),
//             ),
//             Expanded(
//               child: ListView.separated(
//                 separatorBuilder: (context, index) => const SizedBox(width: 6),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: filteredCourses.length,
//                 itemBuilder: (context, index) {
//                   final course = filteredCourses[index];
//                   return _buildCourseList(context, course, index);
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   Widget _buildCourseList(BuildContext context, Course course, int index) {
//     bool isBookmarked =
//         bookmarkedCourses.contains(course.courseCode + course.category);

//     return GestureDetector(
//       onTap: () {
//         if (selectedCategory == 'Syllabus') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Syllabus(
//                 university: _selecteduniversity!,
//                 degree: _selecteddegree!,
//                 course: _selectedcourse!,
//                 semester: _selectedsemester!,
//                 courseName: course.courseName,
//                 category: course.category,
//               ),
//             ),
//           );
//         }
//       },
//       child: SizedBox(
//         height: 245.h,
//         width: 290.v,
//         child: Stack(
//           alignment: Alignment.topCenter,
//           children: [
//             Container(
//               height: 245.h,
//               width: 290.v,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.08),
//                     spreadRadius: 2,
//                     blurRadius: 2,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 134.h,
//                   width: 280.v,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage("assets/images/EduWise.jpg"),
//                         fit: BoxFit.cover),
//                     //color: Colors.black,
//                     borderRadius:
//                         BorderRadius.vertical(top: Radius.circular(20)),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15, right: 19),
//                   child: SizedBox(
//                     width: 245.v,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           child: Padding(
//                             padding: const EdgeInsets.only(bottom: 1),
//                             child: Text(course.category,
//                                 style: CustomTextStyles
//                                     .labelLargeMulishOrangeA700
//                                     .copyWith(color: appTheme.orangeA700)),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             _addToBookmarkCollection(course);
//                           },
//                           child: isBookmarked
//                               ? CustomImageView(
//                                   imagePath: ImageConstant
//                                       .imgBookmarkPrimary, // Change to your bookmarked icon
//                                   height: 18,
//                                   width: 14,
//                                   color: Colors
//                                       .blue, // Change to your desired color
//                                 )
//                               : CustomImageView(
//                                   imagePath: ImageConstant.imgBookmark,
//                                   height: 18,
//                                   width: 14,
//                                 ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 14, right: 10),
//                   child: Text( course.courseName,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: theme.textTheme.titleMedium),
//                 ),
//                 const SizedBox(height: 9),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 13),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 32.v,
//                         margin: const EdgeInsets.only(top: 3),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             CustomImageView(
//                               imagePath: ImageConstant.imgSignal,
//                               height: 11,
//                               width: 12,
//                               margin: EdgeInsets.only(bottom: 2),
//                             ),
//                             Text(course.courseCredit,
//                                 style: theme.textTheme.labelMedium!
//                                     .copyWith(color: appTheme.blueGray90001)),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16),
//                         child: Text("|",
//                             style: CustomTextStyles.titleSmallBlack900
//                                 .copyWith(color: appTheme.black900)),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16, top: 3),
//                         child: Text(course.courseCode,
//                             style: theme.textTheme.labelMedium!
//                                 .copyWith(color: appTheme.blueGray90001)),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLoading() {
//     return Column(
//       children: [
//         Container(
//           height: 45.h,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: List.generate(
//                 5,
//                 (index) => Padding(
//                     padding: const EdgeInsets.all(3.0),
//                     child: Shimmer.fromColors(
//                       baseColor: Colors.grey[300]!,
//                       highlightColor: Colors.grey[100]!,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
                       
//                         width: 90.v,
                        
//                       ),
//                     ))),
//           ),
//         ),
//         Container(
//           height: 245.h,
//           child: ListView(
//             scrollDirection: Axis.horizontal,
//             children: List.generate(
//               5, // Number of shimmer items
//               (index) => Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 240.h,
//                   width: 280.v,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.08),
//                         spreadRadius: 2,
//                         blurRadius: 2,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 134.h,
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage("assets/images/EduWise.jpg"),
//                             fit: BoxFit.cover,
//                           ),
//                           borderRadius:
//                               BorderRadius.vertical(top: Radius.circular(20)),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Shimmer.fromColors(
//                               baseColor: Colors.grey[300]!,
//                               highlightColor: Colors.grey[100]!,
//                               child: Container(
//                                  decoration: BoxDecoration(
//                                   color: Colors.grey[300],
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 height: 10,
//                                 width: 80,
                               
//                               ),
//                             ),
//                             const SizedBox(height: 15),
//                             Shimmer.fromColors(
//                               baseColor: Colors.grey[300]!,
//                               highlightColor: Colors.grey[100]!,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey[300],
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 height: 18,
//                                 width: 190,
//                               ),
//                             ),
//                             const SizedBox(height: 13),
//                             Shimmer.fromColors(
//                               baseColor: Colors.grey[300]!,
//                               highlightColor: Colors.grey[100]!,
//                               child: Container(
//                                  decoration: BoxDecoration(
//                                   color: Colors.grey[300],
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 height: 10,
//                                 width: 160,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
