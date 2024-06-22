import '../subscription_notifications_screen/widgets/todaysectionlist2_item_widget.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image_home.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

// ignore_for_file: must_be_immutable
class SubscriptionNotificationsScreen extends StatelessWidget {
  SubscriptionNotificationsScreen({super.key});

  List todaysectionlist2ItemList = [
    {'id': 1, 'groupBy': "Today"},
    {'id': 2, 'groupBy': "Today"},
    {'id': 3, 'groupBy': "Today"},
    {'id': 4, 'groupBy': "Yesterday"},
    {'id': 5, 'groupBy': "Nov 20, 2022"}
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 33.h, vertical: 2.v),
                child: Column(children: [
                  _buildCategory(context),
                  SizedBox(height: 15.v),
                  _buildTodaySectionList(context),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 61.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowDown,
            margin: EdgeInsets.only(left: 35.h, top: 18.v, bottom: 17.v),
            onTap: () {
              onTapArrowDown(context);
            }),
        title: AppbarSubtitle(
            text: "Notifications", margin: EdgeInsets.only(left: 12.h)));
  }

  /// Section Widget
  Widget _buildCategory(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
          child: CustomElevatedButton(
              height: 48.v,
              text: "App",
              margin: EdgeInsets.only(right: 10.h),
              buttonStyle: CustomButtonStyles.fillBlueTL24,
              buttonTextStyle: CustomTextStyles.titleSmallBluegray90001,
              onPressed: () {
                onTapApp(context);
              })),
      Expanded(
          child: CustomElevatedButton(
              height: 48.v,
              text: "Subscription",
              margin: EdgeInsets.only(left: 10.h),
              buttonStyle: CustomButtonStyles.fillPrimaryTL24,
              buttonTextStyle: CustomTextStyles.titleSmallWhiteA700))
    ]);
  }

  /// Section Widget
  Widget _buildTodaySectionList(BuildContext context) {
    return GroupedListView<dynamic, String>(
        shrinkWrap: true,
        stickyHeaderBackgroundColor: Colors.transparent,
        elements: todaysectionlist2ItemList,
        groupBy: (element) => element['groupBy'],
        sort: false,
        groupSeparatorBuilder: (String value) {
          return Padding(
              padding: EdgeInsets.only(top: 34.v, bottom: 18.v),
              child: Text(value,
                  style: CustomTextStyles.titleMediumBold
                      .copyWith(color: appTheme.blueGray90001)));
        },
        itemBuilder: (context, model) {
          return const Todaysectionlist2ItemWidget();
        },
        separator: SizedBox(height: 12.v));
  }

  /// Navigates to the homemainpageContainerScreen when the action is triggered.
  onTapArrowDown(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
  }

  /// Navigates to the appNotificationsScreen when the action is triggered.
  onTapApp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.appNotificationsScreen);
  }
}
