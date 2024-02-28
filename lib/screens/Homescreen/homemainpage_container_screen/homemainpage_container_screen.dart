import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/Homescreen/homemainpage_page/homemainpage_page.dart';
import 'package:edumike/screens/Homescreen/indoxmainpage_page/indoxmainpage_page.dart';
import 'package:edumike/screens/Homescreen/my_bookmark_page/my_bookmark_page.dart';
import 'package:edumike/screens/Homescreen/my_course_page/my_course_page.dart';
import 'package:edumike/screens/Homescreen/profiles_page/profiles_page.dart';
import 'package:edumike/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class HomemainpageContainerScreen extends StatelessWidget {
  HomemainpageContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA700,
            body: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.homemainpagePage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar: _buildBottomBar(context)));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homemainpagePage;
      case BottomBarEnum.Mycourses:
        return AppRoutes.myCoursePage;
      case BottomBarEnum.Indox:
        return AppRoutes.indoxmainpagePage;
      case BottomBarEnum.Bookmark:
        return AppRoutes.myBookmarkPage;
      case BottomBarEnum.Profile:
        return AppRoutes.profilesPage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homemainpagePage:
        return HomemainpagePage();
      case AppRoutes.myCoursePage:
        return MyCoursePage();
      case AppRoutes.myBookmarkPage:
        return MyBookmarkPage();
      case AppRoutes.indoxmainpagePage:
        return IndoxmainpagePage();
      case AppRoutes.profilesPage:
        return ProfilesPage();
      default:
        return DefaultWidget();
    }
  }
}
