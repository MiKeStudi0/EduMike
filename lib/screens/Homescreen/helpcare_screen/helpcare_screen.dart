import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image_home.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/appbar_trailing_image_home.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_icon_button_home.dart';
import 'package:edumike/widgets/custom_outlined_button_home.dart';
import 'package:flutter/material.dart';

class HelpcareScreen extends StatelessWidget {
  const HelpcareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 16.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomOutlinedButton(
                          height: 32.v,
                          width: 90.h,
                          text: "Today",
                          buttonStyle: CustomButtonStyles.outlineBlueGrayTL8,
                          buttonTextStyle: CustomTextStyles.labelLargeMulish,
                          alignment: Alignment.center),
                      SizedBox(height: 35.v),
                      Padding(
                          padding: EdgeInsets.only(right: 78.h),
                          child: _buildFrameTwentyOneRow(context,
                              greetingText: "Hi, Nicholas Good Ev..",
                              timeText: "10:45")),
                      SizedBox(height: 15.v),
                      Padding(
                          padding: EdgeInsets.only(right: 78.h),
                          child: Row(children: [
                            CustomImageView(
                                imagePath: ImageConstant.imgPattern08,
                                height: 55.v,
                                width: 59.h,
                                radius: BorderRadius.circular(27.h),
                                margin: EdgeInsets.symmetric(vertical: 13.v)),
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left: 6.h),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 7.v),
                                    decoration: AppDecoration.fillBlue.copyWith(
                                        borderRadius:
                                            BorderRadiusStyle.roundedBorder10),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                              height: 40.v,
                                              width: 181.h,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 12.v),
                                              child: Stack(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  children: [
                                                    Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: SizedBox(
                                                            width: 181.h,
                                                            child: Text(
                                                                "How was your UI/UX Design Course Like.?",
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: CustomTextStyles
                                                                    .titleSmallJostBluegray90001SemiBold))),
                                                    CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgTelevisionOrangeA200,
                                                        height: 18.adaptSize,
                                                        width: 18.adaptSize,
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        margin: EdgeInsets.only(
                                                            right: 68.h,
                                                            bottom: 1.v))
                                                  ])),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(top: 51.v),
                                              child: Text("12:45",
                                                  style: theme
                                                      .textTheme.labelMedium))
                                        ])))
                          ])),
                      SizedBox(height: 20.v),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                              padding: EdgeInsets.only(left: 79.h, right: 2.h),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    _buildTodayRow(context,
                                        greetingText: "Hi, Morning too Ronald",
                                        timeText: "15:29"),
                                    CustomImageView(
                                        imagePath: ImageConstant.imgPattern08,
                                        height: 55.v,
                                        width: 59.h,
                                        radius: BorderRadius.circular(27.h),
                                        margin: EdgeInsets.only(
                                            left: 4.h, top: 3.v))
                                  ]))),
                      SizedBox(height: 25.v),
                      Padding(
                          padding: EdgeInsets.only(left: 80.h, right: 2.h),
                          child: _buildFrameTwentyTwoRow(context,
                              greetingText: "Hi, Sorry Ronald",
                              timeText: "15:29")),
                      SizedBox(height: 25.v),
                      Padding(
                          padding: EdgeInsets.only(right: 78.h),
                          child: _buildFrameTwentyOneRow(context,
                              greetingText: "Hi, Nicholas Good Ev..",
                              timeText: "10:45")),
                      SizedBox(height: 25.v),
                      Padding(
                          padding: EdgeInsets.only(left: 80.h, right: 2.h),
                          child: _buildFrameTwentyTwoRow(context,
                              greetingText: "Hi, Sorry Ronald",
                              timeText: "15:29")),
                      SizedBox(height: 5.v)
                    ])),
            bottomNavigationBar: _buildFrameTwentyThreeRow(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 61.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowDown,
            margin: EdgeInsets.only(left: 35.h, top: 19.v, bottom: 16.v),
            onTap: () {
              onTapArrowDown(context);
            }),
        title:
            AppbarSubtitle(text: "Indox", margin: EdgeInsets.only(left: 12.h)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgQrcodeBlueGray90001,
              margin: EdgeInsets.fromLTRB(33.h, 21.v, 33.h, 14.v))
        ]);
  }

  /// Section Widget
  Widget _buildFrameTwentyThreeRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 14.h, right: 14.h, bottom: 30.v),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 13.v),
              child: CustomIconButton(
                  height: 33.adaptSize,
                  width: 33.adaptSize,
                  child: CustomImageView(
                      imagePath: ImageConstant.imgCloseOrangeA200))),
          Container(
              height: 60.v,
              width: 360.h,
              margin: EdgeInsets.only(left: 7.h),
              child: Stack(alignment: Alignment.center, children: [
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.h, vertical: 6.v),
                        decoration: AppDecoration.outlineBlue.copyWith(
                            borderRadius: BorderRadiusStyle.circleBorder30),
                        child: CustomIconButton(
                            height: 48.adaptSize,
                            width: 48.adaptSize,
                            child: const CustomImageView()))),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: 315.h,
                        margin: EdgeInsets.symmetric(
                            horizontal: 22.h, vertical: 19.v),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 2.v),
                                  child: Text("Message",
                                      style:
                                          CustomTextStyles.titleSmallGray500)),
                              CustomImageView(
                                  imagePath: ImageConstant.imgUser,
                                  height: 20.adaptSize,
                                  width: 20.adaptSize)
                            ])))
              ]))
        ]));
  }

  /// Common widget
  Widget _buildTodayRow(
    BuildContext context, {
    required String greetingText,
    required String timeText,
  }) {
    return Expanded(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 7.v),
            decoration: AppDecoration.fillPrimary
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                      padding:
                          EdgeInsets.only(left: 7.h, top: 12.v, bottom: 8.v),
                      child: Text(greetingText,
                          style: CustomTextStyles.titleSmallJostWhiteA700
                              .copyWith(color: appTheme.whiteA700))),
                  Padding(
                      padding: EdgeInsets.only(top: 28.v),
                      child: Text(timeText,
                          style: CustomTextStyles.labelMediumWhiteA700
                              .copyWith(color: appTheme.whiteA700)))
                ])));
  }

  /// Common widget
  Widget _buildFrameTwentyOneRow(
    BuildContext context, {
    required String greetingText,
    required String timeText,
  }) {
    return Row(children: [
      CustomImageView(
          imagePath: ImageConstant.imgPattern08,
          height: 55.v,
          width: 59.h,
          radius: BorderRadius.circular(27.h),
          margin: EdgeInsets.symmetric(vertical: 1.v)),
      Expanded(
          child: Container(
              margin: EdgeInsets.only(left: 7.h),
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.v),
              decoration: AppDecoration.fillBlue
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(left: 10.h, top: 13.v, bottom: 9.v),
                        child: Text(greetingText,
                            style: CustomTextStyles
                                .titleSmallJostBluegray90001SemiBold
                                .copyWith(color: appTheme.blueGray90001))),
                    Padding(
                        padding: EdgeInsets.only(top: 30.v),
                        child: Text(timeText,
                            style: theme.textTheme.labelMedium!
                                .copyWith(color: appTheme.blueGray90001)))
                  ])))
    ]);
  }

  /// Common widget
  Widget _buildFrameTwentyTwoRow(
    BuildContext context, {
    required String greetingText,
    required String timeText,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 7.v),
              decoration: AppDecoration.fillPrimary
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(left: 7.h, top: 12.v, bottom: 8.v),
                        child: Text(greetingText,
                            style: CustomTextStyles.titleSmallJostWhiteA700
                                .copyWith(color: appTheme.whiteA700))),
                    Padding(
                        padding: EdgeInsets.only(top: 28.v),
                        child: Text(timeText,
                            style: CustomTextStyles.labelMediumWhiteA700
                                .copyWith(color: appTheme.whiteA700)))
                  ]))),
      CustomImageView(
          imagePath: ImageConstant.imgPattern08,
          height: 55.v,
          width: 59.h,
          radius: BorderRadius.circular(27.h),
          margin: EdgeInsets.only(left: 3.h, bottom: 3.v))
    ]);
  }

  /// Navigates to the homemainpageContainerScreen when the action is triggered.
  onTapArrowDown(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
  }
}
