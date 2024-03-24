import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/Homescreen/remove_bookmark_screen/remove_bookmark_screen.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class Bookmark {
  final String category;
  final String courseName;
  final String courseCode;
  final String courseCredit;
  final String university;
  final String degree;
  final String course;
  final String semester;

  Bookmark({
    required this.category,
    required this.courseName,
    required this.courseCode,
    required this.courseCredit,
    required this.university,
    required this.degree,
    required this.course,
    required this.semester,
  });
}

class MyBookmarkPage extends StatefulWidget {
  const MyBookmarkPage({Key? key}) : super(key: key);

  @override
  _MyBookmarkPageState createState() => _MyBookmarkPageState();
}

class _MyBookmarkPageState extends State<MyBookmarkPage> {
  List<Bookmark> bookmarks = [];
  List<String> categories = [
    'Syllabus',
    'Notes',
    'Text Book',
    'Question Paper',
    'Question Bank',
    'Lab Manual',
    'Others'
  ];
  String selectedCategory = 'Syllabus';

  @override
  void initState() {
    super.initState();
    loadBookmarkedCourses();
  }

  Future<void> loadBookmarkedCourses() async {
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
          bookmarks = snapshot.docs.map((doc) {
            return Bookmark(
              category: doc['category'] as String,
              courseName: doc['courseName'] as String,
              courseCode: doc['courseCode'] as String,
              courseCredit: doc['courseCredit'] as String,
              university: doc['university'] as String,
              degree: doc['degree'] as String,
              course: doc['course'] as String,
              semester: doc['semester'] as String,
            );
          }).toList();
        });
      }
    } catch (e) {
      // Handle errors
      print('Error loading bookmarked courses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredBookmarks = bookmarks.where((bookmark) {
      return selectedCategory.isEmpty || selectedCategory == bookmark.category;
    }).toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray5001,
        appBar: _buildAppBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterChips(),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return SizedBox(height: 0.v);
                },
                itemCount: filteredBookmarks.length,
                itemBuilder: (context, index) {
                  final bookmark = filteredBookmarks[index];
                  return _buildBookmarkItem(bookmark);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories
            .map(
              (category) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: FilterChip(
                  label: Text(category),
                  selected: selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = selected ? category : '';
                    });
                  },
                  selectedColor: selectedCategory.isEmpty
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primary,
                  labelStyle: TextStyle(
                    color: selectedCategory == category ? Colors.white : null,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

    /// popup varunnath
 void _showBottomSheet(BuildContext context,String Category,String CourseName,String CourseCode,String CourseCredit,String University,String Degree,String Course,String Semester) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
        child: FractionallySizedBox(
          heightFactor: 0.37, // Adjust this value as needed
          child: Container(
            // Set a specific height, you can adjust this value based on your needs
            height: MediaQuery.of(context).size.height * 0.7,
            child: RemoveBookmarkScreen( category: Category, courseName: CourseName, courseCode: CourseCode, courseCredit: CourseCredit, university: University, degree: Degree, course: Course, semester: Semester),
          ),
        ),
      );
    },
  );
}


  Widget _buildBookmarkItem(Bookmark bookmark) {
    return Container(
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
              padding: EdgeInsets.only(left: 14.h, top: 15.v, bottom: 18.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 195.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          bookmark.category,
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
                                  _showBottomSheet(context,bookmark.category,bookmark.courseName,bookmark.courseCode,bookmark.courseCredit,bookmark.university,bookmark.degree,bookmark.course,bookmark.semester);
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
                    bookmark.courseName,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.v),
                  Text(
                    bookmark.courseCode,
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
                                "${bookmark.courseCredit}",
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
    );
  }
// Widget _buildBookmarkItem(Bookmark bookmark) {
//   return Container(
//     margin: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 20.v),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.08),
//           spreadRadius: 2,
//           blurRadius: 2,
//           offset: const Offset(0, 4),
//         ),
//       ],
//     ),
//     child: Row(
//       children: [
//         CustomImageView(
//           imagePath: ImageConstant.imgImage,
//           height: 130.adaptSize,
//           width: 130.adaptSize,
//           radius: BorderRadius.horizontal(
//             left: Radius.circular(20.h),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(left: 14.h, top: 15.v, bottom: 18.v),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: 195.h,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       bookmark.category,
//                       style: CustomTextStyles.labelLargeMulishOrangeA700,
//                     ),
//                     SizedBox(
//                       height: 16.v,
//                       width: 12.h,
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           CustomImageView(
//                             imagePath: ImageConstant.imgBookmarkPrimary,
//                             height: 16.v,
//                             width: 12.h,
//                             alignment: Alignment.center,
//                             onTap: () {},
//                           ),
//                           CustomImageView(
//                             imagePath: ImageConstant.imgBookmarkPrimary,
//                             height: 16.v,
//                             width: 12.h,
//                             alignment: Alignment.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 8.v),
//               Text(
//                 bookmark.courseName,
//                 style: theme.textTheme.titleMedium,
//               ),
//               SizedBox(height: 5.v),
//               Text(
//                 'Course Code: ${bookmark.courseCode}\nCredit: ${bookmark.courseCredit}\n',
//                 style: theme.textTheme.titleSmall,
//               ),
//               SizedBox(height: 5.v),
//               Row(
//                 children: [
//                   Container(
//                     width: 32.h,
//                     margin: EdgeInsets.only(top: 3.v),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CustomImageView(
//                           imagePath: ImageConstant.imgSignal,
//                           height: 11.v,
//                           width: 12.h,
//                           margin: EdgeInsets.only(bottom: 2.v),
//                         ),
//                         Text(
//                           bookmark.courseCredit,
//                           style: theme.textTheme.labelMedium,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 16.h),
//                     child: Text(
//                       "|",
//                       style: CustomTextStyles.titleSmallBlack900,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 16.h, top: 3.v),
//                     child: Text(
//                       bookmark.courseCode,
//                       style: theme.textTheme.labelMedium,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 61.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDown,
        margin: EdgeInsets.only(left: 35.h, top: 17.v, bottom: 18.v),
      ),
      title: AppbarSubtitle(
        text: "My Bookmark",
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }
}
