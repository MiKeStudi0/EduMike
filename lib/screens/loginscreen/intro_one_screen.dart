import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroOneScreen extends StatelessWidget {
  const IntroOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.gray50,
            body: Container(
                width: double.maxFinite,
                padding:
                    EdgeInsets.symmetric(horizontal: 36.h, vertical: 156.v),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    child: CustomImageView(
                        height: 300,
                        width: 300,
                        margin: EdgeInsets.only(bottom: 30.v),
                        imagePath: ImageConstant.imglogo),
                  ),
                  const Spacer(),
                  Text("Welcome to Eduwise",
                      style: theme.textTheme.headlineSmall),
                  SizedBox(height: 6.v),
                  SizedBox(
                      width: 355.h,
                      child: Text(
                          "Unlock Knowledge: Your Ultimate Study Companion",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleSmall))
                ])),
            bottomNavigationBar: _buildPagination(context)));
  }

  /// Section Widget
  Widget _buildPagination(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 34.h, right: 34.h, bottom: 66.v),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              height: 10.v,
              margin: EdgeInsets.symmetric(vertical: 25.v),
              child: AnimatedSmoothIndicator(
                  activeIndex: 0,
                  count: 3,
                  effect: ScrollingDotsEffect(
                      spacing: 15,
                      activeDotColor: appTheme.blueA700,
                      dotColor: appTheme.teal50,
                      dotHeight: 10.v,
                      dotWidth: 10.h))),
          CustomIconButton(
              height: 60.adaptSize,
              width: 60.adaptSize,
              padding: EdgeInsets.all(16.h),
              decoration: IconButtonStyleHelper.outlinePrimary,
              onTap: () {
                onTapBtnArrowRight(context);
              },
              child: CustomImageView(imagePath: ImageConstant.imgArrowRight))
        ]));
  }

  /// Navigates to the letSYouInScreen when the action is triggered.
  onTapBtnArrowRight(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.letSYouInScreen);
  }
}
