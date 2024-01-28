import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image_home.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_icon_button_home.dart';
import 'package:flutter/material.dart';

class ProfilesPage extends StatelessWidget {
  const ProfilesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 27.v),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 28.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                      height: 93.v,
                                      width: 89.h,
                                      child: Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                    height: 89.adaptSize,
                                                    width: 89.adaptSize,
                                                    decoration: BoxDecoration(
                                                        color: appTheme
                                                            .blueGray100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(44.h),
                                                        border: Border.all(
                                                            color: appTheme
                                                                .teal700,
                                                            width: 4.h,
                                                            strokeAlign:
                                                                strokeAlignOutside)))),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 3.h),
                                                child: CustomIconButton(
                                                    height: 29.adaptSize,
                                                    width: 29.adaptSize,
                                                    padding:
                                                        EdgeInsets.all(6.h),
                                                    decoration:
                                                        IconButtonStyleHelper
                                                            .outlineTeal,
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgLock)))
                                          ]))),
                              SizedBox(height: 7.v),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text("Alex",
                                      style: theme.textTheme.headlineSmall)),
                              SizedBox(height: 5.v),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text("hernandex.redial@gmail.ac.in",
                                      style: CustomTextStyles
                                          .labelLargeMulishSecondaryContainerBold)),
                              SizedBox(height: 45.v),
                              _buildOne(context),
                              SizedBox(height: 42.v),
                              _buildTwo(context),
                              SizedBox(height: 42.v),
                              _buildThree(context),
                              SizedBox(height: 43.v),
                              _buildFour(context),
                              SizedBox(height: 43.v),
                              _buildFive(context),
                              SizedBox(height: 44.v),
                              _buildSix(context),
                              SizedBox(height: 43.v),
                              _buildSeven(context),
                              SizedBox(height: 40.v),
                              _buildEight(context),
                              SizedBox(height: 43.v),
                              _buildNine(context),
                              SizedBox(height: 44.v),
                              _buildTen(context)
                            ]))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 61.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowDown,
            margin: EdgeInsets.only(left: 35.h, top: 18.v, bottom: 17.v)),
        title: AppbarSubtitle(
            text: "Profile", margin: EdgeInsets.only(left: 12.h)));
  }

  /// Section Widget
  Widget _buildOne(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTapOne(context);
        },
        child: Padding(
            padding: EdgeInsets.only(left: 20.h),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              CustomImageView(
                  imagePath: ImageConstant.imgSettings,
                  height: 23.v,
                  width: 18.h),
              Padding(
                  padding: EdgeInsets.only(left: 16.h, top: 2.v, bottom: 2.v),
                  child: Text("Edit Profile",
                      style: CustomTextStyles.titleSmallBluegray9000115)),
              Spacer(),
              CustomImageView(
                  imagePath: ImageConstant.imgArrowRight,
                  height: 21.v,
                  width: 12.h,
                  margin: EdgeInsets.only(top: 2.v))
            ])));
  }

  /// Section Widget
  Widget _buildTwo(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomImageView(
              imagePath: ImageConstant.imgFill1, height: 22.v, width: 23.h),
          Padding(
              padding: EdgeInsets.only(left: 11.h, top: 3.v),
              child: Text("Payment Option",
                  style: CustomTextStyles.titleSmallBluegray9000115)),
          Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRight,
              height: 21.v,
              width: 12.h,
              margin: EdgeInsets.only(top: 2.v))
        ]));
  }

  /// Section Widget
  Widget _buildThree(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomImageView(
                imagePath: ImageConstant.imgUserBlueGray90001,
                height: 23.v,
                width: 19.h),
            Padding(
                padding: EdgeInsets.only(left: 15.h, top: 2.v, bottom: 2.v),
                child: Text("Notifications",
                    style: CustomTextStyles.titleSmallBluegray9000115))
          ]),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRight,
              height: 21.v,
              width: 12.h,
              margin: EdgeInsets.only(top: 2.v))
        ]));
  }

  /// Section Widget
  Widget _buildFour(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 19.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomImageView(
              imagePath: ImageConstant.imgTelevisionBlueGray90001,
              height: 23.adaptSize,
              width: 23.adaptSize),
          Padding(
              padding: EdgeInsets.only(left: 12.h, bottom: 2.v),
              child: Text("Security",
                  style: CustomTextStyles.titleSmallBluegray9000115)),
          Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRight, height: 21.v, width: 12.h)
        ]));
  }

  /// Section Widget
  Widget _buildFive(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomImageView(
              imagePath: ImageConstant.imgCloseGray900,
              height: 21.v,
              width: 23.h),
          Padding(
              padding: EdgeInsets.only(left: 11.h, top: 2.v),
              child: Text("Language",
                  style: CustomTextStyles.titleSmallBluegray9000115)),
          Spacer(),
          Padding(
              padding: EdgeInsets.only(top: 3.v),
              child: Text("English (US)",
                  style: CustomTextStyles.titleSmallPrimaryExtraBold)),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRight,
              height: 21.v,
              width: 12.h,
              margin: EdgeInsets.only(left: 17.h))
        ]));
  }

  /// Section Widget
  Widget _buildSix(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomImageView(
              imagePath: ImageConstant.imgEye,
              height: 16.v,
              width: 25.h,
              margin: EdgeInsets.only(bottom: 3.v)),
          Padding(
              padding: EdgeInsets.only(left: 9.h, bottom: 2.v),
              child: Text("Dark Mode",
                  style: CustomTextStyles.titleSmallBluegray9000115)),
          Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRight, height: 21.v, width: 12.h)
        ]));
  }

  /// Section Widget
  Widget _buildSeven(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTapSeven(context);
        },
        child: Padding(
            padding: EdgeInsets.only(left: 22.h),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              CustomImageView(
                  imagePath: ImageConstant.imgUserBlueGray9000121x18,
                  height: 21.v,
                  width: 18.h),
              Padding(
                  padding: EdgeInsets.only(left: 14.h, bottom: 2.v),
                  child: Text("Terms & Conditions",
                      style: CustomTextStyles.titleSmallBluegray9000115)),
              Spacer(),
              CustomImageView(
                  imagePath: ImageConstant.imgArrowRight,
                  height: 21.v,
                  width: 12.h)
            ])));
  }

  /// Section Widget
  Widget _buildEight(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 19.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomImageView(
              imagePath: ImageConstant.imgProfile,
              height: 26.adaptSize,
              width: 26.adaptSize),
          Padding(
              padding: EdgeInsets.only(left: 9.h, top: 4.v, bottom: 3.v),
              child: Text("Help Center",
                  style: CustomTextStyles.titleSmallBluegray9000115)),
          Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRight,
              height: 21.v,
              width: 12.h,
              margin: EdgeInsets.only(top: 4.v))
        ]));
  }

  /// Section Widget
  Widget _buildNine(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTapNine(context);
        },
        child: Padding(
            padding: EdgeInsets.only(left: 20.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 1.v),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                                imagePath: ImageConstant.imgFill1Onprimary,
                                height: 21.v,
                                width: 23.h),
                            Padding(
                                padding: EdgeInsets.only(left: 11.h),
                                child: Text("Intive Friends",
                                    style: CustomTextStyles
                                        .titleSmallBluegray9000115))
                          ])),
                  CustomImageView(
                      imagePath: ImageConstant.imgArrowRight,
                      height: 21.v,
                      width: 12.h)
                ])));
  }

  /// Section Widget
  Widget _buildTen(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomImageView(
              imagePath: ImageConstant.imgClock, height: 19.v, width: 20.h),
          Padding(
              padding: EdgeInsets.only(left: 14.h),
              child: Text("Logout",
                  style: CustomTextStyles.titleSmallBluegray9000115)),
          Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRight, height: 21.v, width: 12.h)
        ]));
  }

  /// Navigates to the editProfilesScreen when the action is triggered.
  onTapOne(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.editProfilesScreen);
  }

  /// Navigates to the termsConditionsScreen when the action is triggered.
  onTapSeven(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.termsConditionsScreen);
  }

  /// Navigates to the inviteFriendsScreen when the action is triggered.
  onTapNine(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.inviteFriendsScreen);
  }
}