import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
import 'package:edumike/widgets/custom_outlined_button_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RemoveBookmarkScreen extends StatelessWidget {
  final String? category;
  final String? courseName;
  final String? courseCode;
  final String? courseCredit;
  final String? university;
  final String? degree;
  final String? course;
  final String? semester;
  


  const RemoveBookmarkScreen({super.key, 
    this.category,
    this.courseName,
    this.courseCode,
    this.courseCredit,
    this.university,
    this.degree,
    this.course,
    this.semester,

  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
              //width: 100.h,
              padding: EdgeInsets.symmetric(
                horizontal: 34.h,
                vertical: 31.v,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 43.h),
                    child: Text(
                      "Remove From Bookmark?",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 23.v),
                  _buildMainStack(context),
                  SizedBox(height: 29.v),
                  _buildCancelButtons(context),
                  SizedBox(height: 5.v),
                ],
              ),
            ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMainStack(BuildContext context) {
    return Container(
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
              padding: EdgeInsets.only(left: 10.h, top: 15.v, bottom: 18.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 195.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category!,
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
                    courseName!,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.v),
                  Text(
                    courseCode!,
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
                                courseCredit!,
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

  /// Section Widget
/// Section Widget
Widget _buildCancelButtons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomOutlinedButton(
        width: 140.h,
        text: "Cancel",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      CustomElevatedButton(
        width: 206.h,
        text: "Yes, Remove",
        onPressed: () {
          _removeBookmark(context);
        },
      ),
    ],
  );
}

void _removeBookmark(BuildContext context) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the user's bookmarks subcollection
      CollectionReference<Map<String, dynamic>> userBookmarksCollection =
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .collection('bookmarks');

      // Query for the bookmarked course
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await userBookmarksCollection
              .where('category', isEqualTo: category)
              .where('courseName', isEqualTo: courseName)
              .where('courseCode', isEqualTo: courseCode)
              .limit(1)
              .get();

      // Check if the bookmark exists
      if (snapshot.docs.isNotEmpty) {
        // Get the document ID of the bookmarked course
        String bookmarkId = snapshot.docs.first.id;

        // Delete the bookmarked course document
        await userBookmarksCollection.doc(bookmarkId).delete();

        // Pop the screen
        Navigator.pop(context);

        // Show a success message or perform any other action as needed
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Bookmark removed successfully"),
        ));
      }
    }
  } catch (e) {
    // Handle errors
    print('Error removing bookmark: $e');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Failed to remove bookmark"),
    ));
  }
}
}