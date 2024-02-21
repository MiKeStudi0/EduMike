import '../my_course_page/widgets/selectedview_item_widget.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image_home.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
import 'package:edumike/widgets/custom_search_view_home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyCoursePage extends StatelessWidget {
  MyCoursePage({Key? key}) : super(key: key);

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
                      Text("Current Semester",
                          style: CustomTextStyles.titleMediumBold),
                      SizedBox(height: 19.v),
                      Expanded(
                        child: _buildSelectedView(context),
                      ),
                      SizedBox(height: 12.v),
                      CustomElevatedButton(
                        text: "Continue Courses",
                        margin: EdgeInsets.only(right: 10.h),
                        rightIcon: Container(
                            padding:
                                EdgeInsets.fromLTRB(14.h, 16.v, 12.h, 14.v),
                            margin: EdgeInsets.only(left: 30.h),
                            decoration: BoxDecoration(
                                color: appTheme.whiteA700,
                                borderRadius: BorderRadius.circular(24.h)),
                            child: CustomImageView(
                                imagePath:
                                    ImageConstant.imgArrowrightPrimary17x21,
                                height: 17.v,
                                width: 21.h)),
                        onPressed: () {
                          onTapContinueCourses(context);
                        },
                      ),
                    ]))));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 61.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowDown,
            margin: EdgeInsets.only(left: 35.h, top: 18.v, bottom: 18.v),
            onTap: () {
              onTapArrowDown(context);
            }),
        title: AppbarSubtitle(
            text: "Courses", margin: EdgeInsets.only(left: 12.h)));
  }

  Widget _buildSelectedView(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(
                '/University/A.P.J. Abdul Kalam Technological University/Refers/B.Tech/Refers/Computer Science and Engineering/Refers/S1/Refers')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final documents = snapshot.data!.docs;

          return ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(height: 12.v);
              },
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final documentId = documents[index].id;
                return SelectedviewItemWidget(courseName: documentId);
              });
        });
  }

  onTapArrowDown(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
  }

  onTapContinueCourses(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.categoryScreen);
  }
}
