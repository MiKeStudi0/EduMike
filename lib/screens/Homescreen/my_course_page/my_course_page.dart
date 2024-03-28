import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/screens/Homescreen/my_course_page/widgets/selectedview_item_widget.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_search_view_home.dart';
import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';



// ignore: must_be_immutable
class MyCoursePage extends StatelessWidget {
  final String? university;
  final String? degree;
  final String? course;
  final String? semester;

  MyCoursePage({
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
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 34.h, vertical: 3.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchView(
                controller: searchController,
                hintText: "Search for …",
                contentPadding: EdgeInsets.only(
                  left: 15.h,
                  top: 21.v,
                  bottom: 21.v,
                ),
              ),
              SizedBox(height: 15.v),
              Text(
                "Current Semester",
                style: CustomTextStyles.titleMediumBold,
              ),
              SizedBox(height: 19.v),
              Expanded(
                child: _buildSelectedView(context),
              ),
              SizedBox(height: 12.v),
            ],
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
    print('university: $university');
    print('degree: $degree');
    print('course: $course');
    print('semester: $semester');

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(
              '/University/$university/Refers/$degree/Refers/$course/Refers/$semester/Refers')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Text("Loading..."));
        }

        final documents = snapshot.data!.docs;

        // Sort documents by courseCredit in decreasing order
        documents.sort((a, b) => int.parse(b['courseCredit']).compareTo(int.parse(a['courseCredit'])));

        return ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(height: 12.v);
          },
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final documentData = documents[index].data() as Map<String, dynamic>;
            final courseName = documentData['courseName'];
            final courseCode = documentData['courseCode'];
            final courseCredit = documentData['courseCredit'];

            if (courseName != null) {
              return SelectedviewItemWidget(
                courseCredit: courseCredit,
                courseName: courseName,
                courseCode: courseCode,
                university: university!,
                degree: degree!,
                course: course!,
                semester: semester!,
              );
            } else {
              return SizedBox.shrink();
            }
          },
        );
      },
    );
  }

  onTapArrowDown(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
  }
}
