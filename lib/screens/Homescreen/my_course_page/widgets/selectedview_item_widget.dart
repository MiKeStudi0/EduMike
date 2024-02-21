import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_icon_button_home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class SelectedviewItemWidget extends StatelessWidget {
  final String courseName;

  const SelectedviewItemWidget({Key? key, required this.courseName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.h,
        top: 19.v,
        bottom: 19.v,
      ),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder18,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(width: 10), // Add some spacing between the icon and text
          Expanded(
            // Use Expanded to allow the text to occupy remaining space
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseName, // Use courseName here
                    style: CustomTextStyles.titleMedium19,
                  ),
                  SizedBox(height: 6.v),
                  Text(
                    "Description..",
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
              width: 10), // Add some spacing between the text and bookmark icon
          CustomImageView(
            imagePath: ImageConstant.imgBookmarkPrimary22x18,
            height: 22.v,
            width: 18.h,
          ),
        ],
      ),
    );
  }
}
