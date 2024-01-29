import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image_home.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
import 'package:flutter/material.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 34.h,
            vertical: 23.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInvite(context),
              SizedBox(height: 15.v),
              Text(
                "Share Invite Via",
                style: CustomTextStyles.titleMedium18,
              ),
              SizedBox(height: 15.v),
              Padding(
                padding: EdgeInsets.only(right: 162.h),
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgFacebook,
                      height: 14.v,
                      width: 7.h,
                      margin: EdgeInsets.only(top: 3.v),
                    ),
                    Spacer(
                      flex: 33,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgTrash,
                      height: 13.v,
                      width: 16.h,
                      margin: EdgeInsets.only(
                        top: 3.v,
                        bottom: 2.v,
                      ),
                    ),
                    Spacer(
                      flex: 33,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgGoogle,
                      height: 14.v,
                      width: 22.h,
                      margin: EdgeInsets.only(top: 3.v),
                    ),
                    Spacer(
                      flex: 33,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgVolume,
                      height: 19.adaptSize,
                      width: 19.adaptSize,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 61.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDown,
        margin: EdgeInsets.only(
          left: 35.h,
          top: 18.v,
          bottom: 17.v,
        ),
      ),
      title: AppbarSubtitle(
        text: "Invite Friends",
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildInviteButton1(BuildContext context) {
    return CustomElevatedButton(
      height: 28.v,
      width: 80.h,
      text: "Invite",
      margin: EdgeInsets.only(
        top: 14.v,
        bottom: 8.v,
      ),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.labelLargeMulishWhiteA700,
    );
  }

  /// Section Widget
  Widget _buildInviteButton2(BuildContext context) {
    return CustomElevatedButton(
      height: 28.v,
      width: 80.h,
      text: "Invite",
      margin: EdgeInsets.only(
        top: 14.v,
        bottom: 8.v,
      ),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.labelLargeMulishWhiteA700,
    );
  }

  /// Section Widget
  Widget _buildInviteButton3(BuildContext context) {
    return CustomElevatedButton(
      height: 28.v,
      width: 80.h,
      text: "Invite",
      margin: EdgeInsets.only(
        top: 12.v,
        bottom: 10.v,
      ),
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.labelLargeMulishBold,
    );
  }

  /// Section Widget
  Widget _buildInviteButton4(BuildContext context) {
    return CustomElevatedButton(
      height: 28.v,
      width: 80.h,
      text: "Invite",
      margin: EdgeInsets.only(
        top: 12.v,
        bottom: 10.v,
      ),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.labelLargeMulishWhiteA700,
    );
  }

  /// Section Widget
  Widget _buildInviteButton5(BuildContext context) {
    return CustomElevatedButton(
      height: 28.v,
      width: 80.h,
      text: "Invite",
      margin: EdgeInsets.only(
        top: 12.v,
        bottom: 10.v,
      ),
      buttonStyle: CustomButtonStyles.fillBlue,
      buttonTextStyle: CustomTextStyles.labelLargeMulishBold,
    );
  }

  /// Section Widget
  Widget _buildInvite(BuildContext context) {
    return SizedBox(
      height: 461.v,
      width: 360.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 22.v),
              decoration: AppDecoration.outlineBlack.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder15,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 184.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50.adaptSize,
                                width: 50.adaptSize,
                                decoration: BoxDecoration(
                                  color: appTheme.black900,
                                  borderRadius: BorderRadius.circular(
                                    25.h,
                                  ),
                                  border: Border.all(
                                    color: appTheme.blue50,
                                    width: 2.h,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 4.v,
                                  bottom: 2.v,
                                ),
                                child: _buildDominickSJenkins(
                                  context,
                                  userName: "Rani Thomas",
                                  phoneNumber: "(+91) 702-897-7965",
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildInviteButton1(context),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.v),
                  Divider(),
                  SizedBox(height: 20.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50.adaptSize,
                          width: 50.adaptSize,
                          decoration: BoxDecoration(
                            color: appTheme.black900,
                            borderRadius: BorderRadius.circular(
                              25.h,
                            ),
                            border: Border.all(
                              color: appTheme.blue50,
                              width: 2.h,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 8.h,
                            top: 5.v,
                            bottom: 2.v,
                          ),
                          child: _buildDominickSJenkins(
                            context,
                            userName: "Anastasia",
                            phoneNumber: "(+91) 702-897-7965",
                          ),
                        ),
                        Spacer(),
                        _buildInviteButton2(context),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.v),
                  Divider(),
                  SizedBox(height: 20.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50.adaptSize,
                          width: 50.adaptSize,
                          decoration: BoxDecoration(
                            color: appTheme.black900,
                            borderRadius: BorderRadius.circular(
                              25.h,
                            ),
                            border: Border.all(
                              color: appTheme.blue50,
                              width: 2.h,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 8.h,
                            top: 5.v,
                            bottom: 3.v,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vaibhav",
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                "(+91)b727-688-4052",
                                style: CustomTextStyles
                                    .labelLargeMulishSecondaryContainerBold,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        _buildInviteButton3(context),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.v),
                  Divider(),
                  SizedBox(height: 20.v),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50.adaptSize,
                          width: 50.adaptSize,
                          decoration: BoxDecoration(
                            color: appTheme.black900,
                            borderRadius: BorderRadius.circular(
                              25.h,
                            ),
                            border: Border.all(
                              color: appTheme.blue50,
                              width: 2.h,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 8.h,
                            top: 6.v,
                            bottom: 2.v,
                          ),
                          child: _buildDominickSJenkins(
                            context,
                            userName: "Rahul Juman",
                            phoneNumber: "(+91) 601-897-1714",
                          ),
                        ),
                        Spacer(),
                        _buildInviteButton4(context),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.v),
                  Divider(),
                  SizedBox(height: 68.v),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50.adaptSize,
                        width: 50.adaptSize,
                        decoration: BoxDecoration(
                          color: appTheme.black900,
                          borderRadius: BorderRadius.circular(
                            25.h,
                          ),
                          border: Border.all(
                            color: appTheme.blue50,
                            width: 2.h,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8.h,
                          top: 6.v,
                          bottom: 4.v,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Abby",
                              style: theme.textTheme.titleMedium,
                            ),
                            Text(
                              "(+91) 802-312-3206",
                              style: CustomTextStyles
                                  .labelLargeMulishSecondaryContainerBold,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      _buildInviteButton5(context),
                    ],
                  ),
                ),
                SizedBox(height: 20.v),
                Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildDominickSJenkins(
    BuildContext context, {
    required String userName,
    required String phoneNumber,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName,
          style: theme.textTheme.titleMedium!.copyWith(
            color: appTheme.blueGray90001,
          ),
        ),
        Text(
          phoneNumber,
          style:
              CustomTextStyles.labelLargeMulishSecondaryContainerBold.copyWith(
            color: theme.colorScheme.secondaryContainer,
          ),
        ),
      ],
    );
  }
}
