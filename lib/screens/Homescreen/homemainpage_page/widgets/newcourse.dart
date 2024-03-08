// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:edumike/core/app_export.dart';
// import 'package:edumike/widgets/custom_image_view.dart';
// import 'package:flutter/material.dart';

// class Course {
//   final String courseName;
//   final String category;
//   final String courseCode;
//   final String courseCredit;
//   final String selectedDocumentId;

//   Course({
//     required this.courseName,
//     required this.category,
//     required this.courseCode,
//     required this.courseCredit,
//     required this.selectedDocumentId,
//   });
// }

// List<Course> courseList = [];

// class CourseList extends StatefulWidget {
//   const CourseList({Key? key}) : super(key: key);

//   @override
//   State<CourseList> createState() => _CourseListState();
// }

// class _CourseListState extends State<CourseList> {
//    List<String> dataList = [];
//   @override
//   void initState() {
//     super.initState();
//     fetchCoursesData();
//     fetchData();

//   }
//   Future<void> fetchData() async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   List<String> collectionPaths = ['/University/A.P.J. Abdul Kalam Technological University/Refers/B.Tech/Refers/Computer Science and Engineering/Refers/S1/Refers/BASICS OF CIVIL & MECHANICAL ENGINEERING/Refers', '/University/A.P.J. Abdul Kalam Technological University/Refers/B.Tech/Refers/Computer Science and Engineering/Refers/S1/Refers'];

//   for (String collectionPath in collectionPaths) {
//     // Reference to the specific collection using the path
//     CollectionReference collectionReference = firestore.collection(collectionPath);

//     QuerySnapshot querySnapshot = await collectionReference.get();

//     for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
//       Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
// dataList.add('Data from $collectionPath: $data');
//       print('Data from $collectionPath: $data');
//       printDataList();
//     }
//   }
// }
//  void printDataList() {
//     // Print each item in the list
//     for (String item in dataList) {
//       print(item);
//     }
//   }
//   Future<void> fetchCoursesData() async {
//     try {
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection(
//               '/University/A.P.J. Abdul Kalam Technological University/Refers/B.Tech/Refers/Computer Science and Engineering/Refers/S1/Refers/BASICS OF CIVIL & MECHANICAL ENGINEERING/Refers/') // Replace with your actual collection path
//           .get();

//       courseList = snapshot.docs.map((doc) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         return Course(
//           category: doc.id,
//           courseName: data['courseName'] ?? '',
//           selectedDocumentId: data['category'] ?? '',
//           courseCode: data['courseCode'] ?? '',
//           courseCredit: data['courseCredit'] ?? '',
//         );
//       }).toList();

//       setState(() {});
//     } catch (e) {
//       print("Error fetching course data: $e");
//     }
//   }

//   final List<String> categories = ['SYLLABUS', 'Notes'];
//   String selectedCategory = 'SYLLABUS';

//   @override
//   Widget build(BuildContext context) {
//     final filteredCourses = courseList.where((course) {
//       return selectedCategory.isEmpty || selectedCategory == course.category;
//     }).toList();

//     return SizedBox(
//       height: 340.h,
//       width: 400.v,
//       child: Column(
//         children: [
//           // Filter Widget in the Body
//           Container(
//             height: 50,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: categories
//                   .map(
//                     (category) => Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: FilterChip(
//                         label: Text(category),
//                         selected: selectedCategory == category,
//                         onSelected: (selected) {
//                           setState(() {
//                             selectedCategory = selected ? category : 'Syllabus';
//                           });
//                         },
//                         selectedColor: selectedCategory == 'Syllabus' ||
//                                 selectedCategory == 'Notes'
//                             ? theme.colorScheme.primary
//                             : theme.colorScheme.primary,
//                         labelStyle: TextStyle(
//                           color: selectedCategory == category
//                               ? Colors.white
//                               : null,
//                         ),
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),
//           // Course List
//           Expanded(
//             child: ListView.separated(
//               separatorBuilder: (context, index) => const SizedBox(width: 10),
//               scrollDirection: Axis.horizontal,
//               itemCount: filteredCourses.length,
//               itemBuilder: (context, index) {
//                 final course = filteredCourses[index];
//                 return _buildCourseList(context, course);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCourseList(BuildContext context, Course course) {
//     return SizedBox(
//       height: 245.h,
//       width: 290.v,
//       child: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           Container(
//             height: 245.h,
//             width: 290.v,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.08),
//                   spreadRadius: 2,
//                   blurRadius: 2,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 134,
//                 width: 280,
//                 decoration: const BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 19),
//                 child: SizedBox(
//                   width: 245,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         child: Padding(
//                           padding: const EdgeInsets.only(bottom: 1),
//                           child: Text(course.category,
//                               style: CustomTextStyles.labelLargeMulishOrangeA700
//                                   .copyWith(color: appTheme.orangeA700)),
//                         ),
//                       ),
//                       // Replace this with your bookmark icon
//                       CustomImageView(
//                           imagePath: ImageConstant.imgBookmark,
//                           height: 18,
//                           width: 14)
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Padding(
//                 padding: const EdgeInsets.only(left: 14, right: 10),
//                 child: Text(course.courseName,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: theme.textTheme.titleMedium),
//               ),
//               const SizedBox(height: 9),
//               Padding(
//                 padding: const EdgeInsets.only(left: 13),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 32,
//                       margin: const EdgeInsets.only(top: 3),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Replace this with your signal icon
//                           CustomImageView(
//                             imagePath: ImageConstant.imgSignal,
//                             height: 11,
//                             width: 12,
//                             margin: EdgeInsets.only(bottom: 2),
//                           ),
//                           Text(course.courseCredit,
//                               style: theme.textTheme.labelMedium!
//                                   .copyWith(color: appTheme.blueGray90001)),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 16),
//                       child: Text("|",
//                           style: CustomTextStyles.titleSmallBlack900
//                               .copyWith(color: appTheme.black900)),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 16, top: 3),
//                       child: Text(course.courseCode,
//                           style: theme.textTheme.labelMedium!
//                               .copyWith(color: appTheme.blueGray90001)),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
