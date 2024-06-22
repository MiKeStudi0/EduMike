import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_icon_button_home.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Todaysectionlist2ItemWidget extends StatelessWidget {
  const Todaysectionlist2ItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      color: appTheme.blue50,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.blueGray200.withOpacity(0.2),
          width: 2.h,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder18,
      ),
      child: Container(
        height: 100.v,
        width: 360.h,
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 19.v,
        ),
        decoration: AppDecoration.outlineBlueGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder18,
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 18.h,
                  bottom: 4.v,
                ),
                child: Text(
                  "New the 3D Design Course is Availa..",
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomIconButton(
                    height: 52.adaptSize,
                    width: 52.adaptSize,
                    padding: EdgeInsets.all(16.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgGrid,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8.h,
                      top: 3.v,
                      bottom: 20.v,
                    ),
                    child: Text(
                      "New Category Course.!",
                      style: CustomTextStyles.titleMedium19,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
