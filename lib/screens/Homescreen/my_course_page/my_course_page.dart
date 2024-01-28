import '../my_course_page/widgets/selectedview_item_widget.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image_home.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
import 'package:edumike/widgets/custom_search_view_home.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
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
                              left: 15.h, top: 21.v, bottom: 21.v)),
                      SizedBox(height: 15.v),
                      Text("Current Semester",
                          style: CustomTextStyles.titleMediumBold),
                      SizedBox(height: 19.v),
                      _buildSelectedView(context),
                      Spacer(),
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
                          })
                    ]))));
  }

  /// Section Widget
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

  /// Section Widget
  Widget _buildSelectedView(BuildContext context) {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 12.v);
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return SelectedviewItemWidget();
        });
  }

  /// Navigates to the homemainpageContainerScreen when the action is triggered.
  onTapArrowDown(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
  }

  /// Navigates to the categoryScreen when the action is triggered.
  onTapContinueCourses(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.categoryScreen);
  }
}
