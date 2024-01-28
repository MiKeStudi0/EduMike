import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image_home.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
import 'package:flutter/material.dart';

class ModulesScreen extends StatelessWidget {
  const ModulesScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 35.h,
            vertical: 17.v,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 644.v),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Module",
                        style: CustomTextStyles.titleSmallJostff202244,
                      ),
                      TextSpan(
                        text: " 01 - ",
                        style: CustomTextStyles.titleSmallJostff202244,
                      ),
                      TextSpan(
                        text: "Introducation",
                        style: CustomTextStyles.titleSmallJostff00acea,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgStroke2,
                height: 5.v,
                width: 10.h,
                margin: EdgeInsets.only(
                  left: 7.h,
                  top: 9.v,
                  bottom: 652.v,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildContinueColumn(context),
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
        text: "Modules",
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildContinueColumn(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 39.h,
        right: 39.h,
        bottom: 53.v,
      ),
      decoration: AppDecoration.outlineBlack9002,
      child: CustomElevatedButton(
        text: "Continue",
        rightIcon: Container(
          padding: EdgeInsets.fromLTRB(14.h, 16.v, 12.h, 14.v),
          margin: EdgeInsets.only(left: 30.h),
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            borderRadius: BorderRadius.circular(
              24.h,
            ),
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgArrowrightPrimary17x21,
            height: 17.v,
            width: 21.h,
          ),
        ),
      ),
    );
  }
}