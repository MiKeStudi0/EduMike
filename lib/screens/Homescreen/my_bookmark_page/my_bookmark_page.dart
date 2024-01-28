import '../my_bookmark_page/widgets/coursedetails_item_widget.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image_home.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:flutter/material.dart';

class MyBookmarkPage extends StatelessWidget {
  const MyBookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA700,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 26.v),
                    child: Container(
                        height: 761.v,
                        width: 394.h,
                        margin: EdgeInsets.only(left: 34.h),
                        child: Stack(alignment: Alignment.topCenter, children: [
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                  margin: EdgeInsets.only(right: 34.h),
                                  decoration: AppDecoration.fillGray,
                                  child: _buildCourseDetails(context))),
                          _buildCategory(context)
                        ]))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 61.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowDown,
            margin: EdgeInsets.only(left: 35.h, top: 17.v, bottom: 18.v)),
        title: AppbarSubtitle(
            text: "My Bookmark", margin: EdgeInsets.only(left: 12.h)));
  }

  /// Section Widget
  Widget _buildCourseDetails(BuildContext context) {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 16.v);
        },
        itemCount: 5,
        itemBuilder: (context, index) {
          return CoursedetailsItemWidget(onTapImgBookmarkImage1: () {
            onTapImgBookmarkImage1(context);
          });
        });
  }

  /// Section Widget
  Widget _buildCategory(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.only(bottom: 731.v),
            padding: EdgeInsets.symmetric(vertical: 4.v),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 21.h),
                      child: Text("All",
                          style: CustomTextStyles.labelLargeMulishBold)),
                  Spacer(flex: 30),
                  Padding(
                      padding: EdgeInsets.only(top: 3.v),
                      child: Text("Syllabus",
                          style: CustomTextStyles.labelLargeMulishWhiteA700)),
                  Spacer(flex: 36),
                  Padding(
                      padding: EdgeInsets.only(top: 2.v),
                      child: Text("Notes",
                          style: CustomTextStyles.labelLargeMulishBold)),
                  Spacer(flex: 32),
                  Padding(
                      padding: EdgeInsets.only(top: 3.v),
                      child: Text("Question Paper",
                          textAlign: TextAlign.center,
                          style: CustomTextStyles.labelLargeMulishBold))
                ])));
  }

  /// Navigates to the removeBookmarkScreen when the action is triggered.
  onTapImgBookmarkImage1(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.removeBookmarkScreen);
  }
}
