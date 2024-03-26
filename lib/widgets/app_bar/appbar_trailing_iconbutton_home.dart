import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/Homescreen/app_notifications_screen/app_notifications_screen.dart';
import 'package:edumike/widgets/custom_icon_button_home.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppbarTrailingIconbutton extends StatelessWidget {
  AppbarTrailingIconbutton({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomIconButton(
          height: 40.adaptSize,
          width: 40.adaptSize,
          decoration: IconButtonStyleHelper.outlinePrimary,
          child: CustomImageView(
            height: 18.adaptSize,
            width: 15.3.adaptSize,
            imagePath: ImageConstant.imgNotification,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AppbarTrailNotification extends StatelessWidget {
  AppbarTrailNotification({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AppNotificationsScreen()));
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomIconButton(
          height: 40.adaptSize,
          width: 40.adaptSize,
          decoration: IconButtonStyleHelper.outlinePrimary,
          child: CustomImageView(
            height: 18.adaptSize,
            width: 15.3.adaptSize,
            imagePath: ImageConstant.imgNotification,
          ),
        ),
      ),
    );
  }
}
