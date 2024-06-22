import 'package:edumike/core/app_export.dart';
import 'package:flutter/material.dart';

class AppNavigationHomeScreen extends StatelessWidget {
  const AppNavigationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "1_HomeMainPage - Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.homemainpageContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Add University Card",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.addUniversityCardScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "HelpCare",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.helpcareScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "6_EDIT PROFILES",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.editProfilesScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "17_INVITE FRIENDS",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.inviteFriendsScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "15_TERMS & CONDITIONS",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.termsConditionsScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Remove_BOOKMARK",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.removeBookmarkScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Add_Subscribe",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.addSubscribeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "App_NOTIFICATIONS",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.appNotificationsScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Subscription_NOTIFICATIONS",
                          onTapScreenTitle: () => onTapScreenTitle(context,
                              AppRoutes.subscriptionNotificationsScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "10_SEARCH",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.searchScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "9_MODULES",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.modulesScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "6_Subscription",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.subscriptionScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "8_CATEGORY",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.categoryScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: const Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle!.call();
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0XFF000000),
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: const Color(0XFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
