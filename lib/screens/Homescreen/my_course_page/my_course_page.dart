import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/screens/Homescreen/category_screen/category_screen.dart';
import 'package:edumike/screens/Homescreen/search_screen/dummy.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';

// ignore: must_be_immutable
class MyCoursePage extends StatelessWidget {
  final String? university;
  final String? degree;
  final String? course;
  final String? semester;

  MyCoursePage({super.key, 
    this.university,
    this.degree,
    this.course,
    this.semester,
  });

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 34.h, vertical: 3.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 0.90,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            child: SearchCourse(
                              university: university!,
                              degree: degree!,
                              course: course!,
                              semester: semester!,
                            ),
                          ),
                        );
                      },
                      backgroundColor: Colors.transparent,
                    );
                  },
                  child:  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                            width: 414.h,
                            height: 52.v,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.blue, Colors.lightBlueAccent],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                  offset: const Offset(
                                      0, 5), // Adjust the vertical offset
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                    width:
                                        8), // Add some space between icon and text
                                Text(
                                  "Search Courses",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Current Semester",
                  style: CustomTextStyles.titleMediumBold,
                ),
                SizedBox(height: 19.v),
                _buildSelectedView(context),
                SizedBox(height: 12.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 61.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDown,
        margin: EdgeInsets.only(left: 35.h, top: 18.v, bottom: 18.v),
        onTap: () {
          onTapArrowDown(context);
        },
      ),
      title: AppbarSubtitle(
        text: "Courses",
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }

  Widget _buildSelectedView(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(
              '/University/$university/Refers/$degree/Refers/$course/Refers/$semester/Refers')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text("Loading..."));
        }

        final documents = snapshot.data!.docs;

        // Sort documents by courseCredit in decreasing order
        documents.sort((a, b) => int.parse(b['courseCredit'])
            .compareTo(int.parse(a['courseCredit'])));

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(height: 12.v);
          },
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final documentData =
                documents[index].data() as Map<String, dynamic>;
            final courseName = documentData['courseName'];
            final courseCode = documentData['courseCode'];
            final courseCredit = documentData['courseCredit'];

            if (courseName != null) {
              return _buildListView(
                  context, courseCredit, courseName, courseCode);
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }

  Widget _buildListView(BuildContext context, String courseCredit,
      String courseName, String courseCode) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              university: university,
              degree: degree,
              course: course,
              semester: semester,
              courseName: courseName,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 16.h,
          top: 19.v,
          bottom: 19.v,
        ),
        decoration: AppDecoration.outlineBlueGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder18,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 1.v),
              child: CustomIconButton(
                height: 52.adaptSize,
                width: 52.adaptSize,
                padding: EdgeInsets.all(16.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgTelevisionBlack900,
                ),
              ),
            ),
            const SizedBox(
                width: 10), // Add some spacing between the icon and text
            Expanded(
              // Use Expanded to allow the text to occupy remaining space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseName, // Use courseName here
                    style: CustomTextStyles.titleMedium19,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.v),
                  Text(
                    courseCode,
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ), // Add some spacing between the text and bookmark icon
          ],
        ),
      ),
    );
  }

  onTapArrowDown(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
  }
}
