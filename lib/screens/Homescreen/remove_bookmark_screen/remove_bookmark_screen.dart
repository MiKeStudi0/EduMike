import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
import 'package:edumike/widgets/custom_outlined_button_home.dart';
import 'package:flutter/material.dart';

class RemoveBookmarkScreen extends StatelessWidget {
  const RemoveBookmarkScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 34.h,
            vertical: 31.v,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 43.h),
                child: Text(
                  "Remove From Bookmark?",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 23.v),
              _buildMainStack(context),
              SizedBox(height: 29.v),
              _buildCancelButtons(context),
              SizedBox(height: 5.v),
            ],
          ),
        );
  }

  /// Section Widget
  Widget _buildMainStack(BuildContext context) {
    return SizedBox(
      height: 131.v,
      width: 360.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(bottom: 1.v),
              decoration: AppDecoration.outlineBlack.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder15,
              ),
              child: Row(
                children: [
                  Container(
                    height: 130.adaptSize,
                    width: 130.adaptSize,
                    decoration: BoxDecoration(
                      color: appTheme.black900,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(16.h),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 14.h,
                      top: 15.v,
                      bottom: 18.v,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Graphic Design",
                          style: CustomTextStyles.labelLargeMulishOrangeA700,
                        ),
                        SizedBox(height: 8.v),
                        Text(
                          "Advertisement Design",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 5.v),
                        Text(
                          "Description..",
                          style: theme.textTheme.titleSmall,
                        ),
                        SizedBox(height: 6.v),
                        Row(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgSignal,
                              height: 11.v,
                              width: 12.h,
                              margin: EdgeInsets.symmetric(vertical: 2.v),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 3.h,
                                top: 2.v,
                              ),
                              child: Text(
                                "3.9",
                                style: theme.textTheme.labelMedium,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 9.h),
                              child: Text(
                                "|",
                                style: CustomTextStyles.titleSmallBlack900,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.h,
                                top: 2.v,
                              ),
                              child: Text(
                                "12680 Std",
                                style: theme.textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgBookmarkPrimary,
                    height: 16.v,
                    width: 12.h,
                    margin: EdgeInsets.only(
                      left: 23.h,
                      top: 15.v,
                      bottom: 99.v,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage,
            height: 130.adaptSize,
            width: 130.adaptSize,
            radius: BorderRadius.horizontal(
              left: Radius.circular(16.h),
            ),
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCancelButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomOutlinedButton(
          width: 140.h,
          text: "Cancel",
        ),
        CustomElevatedButton(
          width: 206.h,
          text: "Yes, Remove",
        ),
      ],
    );
  }
}
