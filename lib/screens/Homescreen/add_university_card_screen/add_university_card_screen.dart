import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_drop_down_home.dart';
import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
import 'package:edumike/widgets/custom_outlined_button_home.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AddUniversityCardScreen extends StatelessWidget {
  AddUniversityCardScreen({Key? key}) : super(key: key);

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList1 = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList2 = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList3 = ["Item One", "Item Two", "Item Three"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 28.h, vertical: 25.v),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 101.h),
                          child: Text("Add Your Card",
                              style: theme.textTheme.titleLarge)),
                      SizedBox(height: 7.v),
                      _buildUniversity(context),
                      SizedBox(height: 13.v),
                      _buildDegree(context),
                      SizedBox(height: 20.v),
                      _buildCourse(context),
                      SizedBox(height: 25.v),
                      _buildSemester(context),
                      SizedBox(height: 28.v),
                      _buildCancel(context),
                      SizedBox(height: 5.v)
                    ]))));
  }

  /// Section Widget
  Widget _buildUniversity(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.h, right: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("University",
              style: CustomTextStyles.titleMediumMontserratBluegray900),
          SizedBox(height: 6.v),
          CustomDropDown(
              hintText: "Select  University",
              items: dropdownItemList,
              onChanged: (value) {})
        ]));
  }

  /// Section Widget
  Widget _buildDegree(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.h, right: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Degree",
              style: CustomTextStyles.titleMediumMontserratBluegray900),
          SizedBox(height: 6.v),
          CustomDropDown(
              hintText: "Select Degree",
              items: dropdownItemList1,
              onChanged: (value) {})
        ]));
  }

  /// Section Widget
  Widget _buildCourse(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.h, right: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Course",
              style: CustomTextStyles.titleMediumMontserratBluegray900),
          SizedBox(height: 7.v),
          CustomDropDown(
              hintText: "Select Course",
              items: dropdownItemList2,
              onChanged: (value) {})
        ]));
  }

  /// Section Widget
  Widget _buildSemester(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.h, right: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Semester",
              style: CustomTextStyles.titleMediumMontserratBluegray900),
          SizedBox(height: 7.v),
          CustomDropDown(
              hintText: "Select Semester",
              items: dropdownItemList3,
              onChanged: (value) {})
        ]));
  }

  /// Section Widget
  Widget _buildCancel(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 13.h),
        child: Row(children: [
          CustomOutlinedButton(
              width: 140.h,
              text: "Cancel",
              onPressed: () {
                onTapCancel(context);
              }),
          CustomElevatedButton(
              width: 206.h,
              text: "Yes, Change",
              margin: EdgeInsets.only(left: 13.h),
              onPressed: () {
                onTapYesChange(context);
              })
        ]));
  }

  /// Navigates to the homemainpageContainerScreen when the action is triggered.
  onTapCancel(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
  }

  /// Navigates to the homemainpageContainerScreen when the action is triggered.
  onTapYesChange(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
  }
}