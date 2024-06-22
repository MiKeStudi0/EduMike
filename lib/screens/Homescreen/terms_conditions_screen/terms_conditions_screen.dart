import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 27.h,
            vertical: 19.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.h),
                child: Text(
                  "Conditions & Attending",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 23.v),
              Container(
                width: 368.h,
                margin: EdgeInsets.only(left: 4.h),
                child: Text(
                  "Welcome to EduWise! These terms and conditions outline the rules and regulations for the use of MikeStudio mobile application.\nBy accessing this app, we assume you accept these terms and conditions. Do not continue to use [Your App Name] if you do not agree to take all of the terms and conditions stated on this page.",
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.titleSmallGray800,
                ),
              ),
              SizedBox(height: 21.v),
              Padding(
                padding: EdgeInsets.only(left: 5.h),
                child: Text(
                  "Terms & Use",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 16.v),
              Container(
                width: 360.h,
                margin: EdgeInsets.only(
                  left: 4.h,
                  right: 7.h,
                ),
                child: Text(
                  "By downloading, installing, or using [Your App Name], you agree to be bound by the following terms of use. If you do not agree with these terms, please do not use the app.",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: CustomTextStyles.titleSmallGray800,
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
       leading: IconButton(
      icon:const Icon(Icons.arrow_back),
      iconSize: 30, 
      onPressed: () {
        Navigator.of(context).pop(); // Navigate back when back arrow is pressed
      },
    ),
      title: AppbarSubtitle(
        text: "Terms & Conditions",
        margin: EdgeInsets.only(left: 13.h),
      ),
    );
  }
}
