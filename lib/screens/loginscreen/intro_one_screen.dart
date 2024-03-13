import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroOneScreen extends StatelessWidget {
  const IntroOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray50,
        body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 36.h, vertical: 156.v),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                child: CustomImageView(
                    height: 300,
                    width: 300,
                    margin: EdgeInsets.only(bottom: 30.v),
                    imagePath: ImageConstant.imglogo),
              ),
              const Spacer(),
              Text("Welcome to Eduwise", style: theme.textTheme.headlineSmall),
              SizedBox(height: 6.v),
              SizedBox(
                  width: 355.h,
                  child: Text("Unlock Knowledge: Your Ultimate Study Companion",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleSmall))
            ])),
      ),
    );
  }

  /// Navigates to the letSYouInScreen when the action is triggered.
}
