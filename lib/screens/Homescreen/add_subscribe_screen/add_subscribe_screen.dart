import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
import 'package:edumike/widgets/custom_outlined_button_home.dart';
import 'package:flutter/material.dart';

class AddSubscribeScreen extends StatelessWidget {
  const AddSubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 18.v),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(height: 24.v),
                  _buildFrameTwentyFour(context),
                  SizedBox(height: 8.v),
                  _buildSeventySeven(context)
                ]))));
  }

  /// Section Widget
  Widget _buildFrameTwentyFour(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 18.h, right: 4.h),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                Container(
                    height: 70.v,
                    width: 80.h,
                    decoration: BoxDecoration(
                        color: appTheme.black900,
                        borderRadius: BorderRadius.circular(20.h))),
                SizedBox(height: 6.v),
                Text("item1", style: theme.textTheme.labelLarge)
              ]),
              Padding(
                  padding: EdgeInsets.only(top: 18.v, bottom: 46.v),
                  child: Text("Subscribe Notification?",
                      style: theme.textTheme.titleLarge))
            ]));
  }

  /// Section Widget
  Widget _buildSeventySeven(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 7.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomOutlinedButton(
              width: 140.h,
              text: "Cancel",
              onPressed: () {
                onTapCancel(context);
              }),
          CustomElevatedButton(
              width: 206.h,
              text: "Yes, Subscribe",
              onPressed: () {
                onTapYesSubscribe(context);
              })
        ]));
  }

  /// Navigates to the homemainpageContainerScreen when the action is triggered.
  onTapCancel(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
  }

  /// Navigates to the homemainpageContainerScreen when the action is triggered.
  onTapYesSubscribe(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
  }
}
