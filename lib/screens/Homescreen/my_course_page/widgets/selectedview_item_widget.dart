import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_icon_button_home.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectedviewItemWidget extends StatelessWidget {
  const SelectedviewItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 19.v,
      ),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 194.h,
            margin: EdgeInsets.only(bottom: 4.v),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 1.v),
                  child: CustomIconButton(
                    height: 52.adaptSize,
                    width: 52.adaptSize,
                    padding: EdgeInsets.all(16.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgTelevisionBlack900,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Course 1.!",
                      style: CustomTextStyles.titleMedium19,
                    ),
                    SizedBox(height: 6.v),
                    Text(
                      "Description..",
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgBookmarkPrimary22x18,
            height: 22.v,
            width: 18.h,
            margin: EdgeInsets.only(
              top: 11.v,
              right: 23.h,
              bottom: 24.v,
            ),
          ),
        ],
      ),
    );
  }
}
