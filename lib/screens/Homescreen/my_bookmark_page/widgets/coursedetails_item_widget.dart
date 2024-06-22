import 'package:edumike/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoursedetailsItemWidget extends StatelessWidget {
  CoursedetailsItemWidget({
    super.key,
    this.onTapImgBookmarkImage1,
  });

  VoidCallback? onTapImgBookmarkImage1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.outlineBlack.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder15,
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage,
            height: 130.adaptSize,
            width: 130.adaptSize,
            radius: BorderRadius.horizontal(
              left: Radius.circular(16.h),
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
                SizedBox(
                  width: 195.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Syllabus",
                        style: CustomTextStyles.labelLargeMulishOrangeA700,
                      ),
                      SizedBox(
                        height: 16.v,
                        width: 12.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgBookmarkPrimary,
                              height: 16.v,
                              width: 12.h,
                              alignment: Alignment.center,
                              onTap: () {
                                onTapImgBookmarkImage1!.call();
                              },
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgBookmarkPrimary,
                              height: 16.v,
                              width: 12.h,
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.v),
                Text(
                  "Computer Network...",
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 5.v),
                Text(
                  "Description..",
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 5.v),
                Row(
                  children: [
                    Container(
                      width: 32.h,
                      margin: EdgeInsets.only(top: 3.v),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgSignal,
                            height: 11.v,
                            width: 12.h,
                            margin: EdgeInsets.only(bottom: 2.v),
                          ),
                          Text(
                            "4.2",
                            style: theme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.h),
                      child: Text(
                        "|",
                        style: CustomTextStyles.titleSmallBlack900,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.h,
                        top: 3.v,
                      ),
                      child: Text(
                        "7830 Std",
                        style: theme.textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
