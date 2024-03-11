// import '../subscription_screen/widgets/viewhierarchy_item_widget.dart';
// import 'package:edumike/core/app_export.dart';
// import 'package:edumike/screens/Homescreen/homemainpage_page/homemainpage_page.dart';
// import 'package:edumike/screens/Homescreen/indoxmainpage_page/indoxmainpage_page.dart';
// import 'package:edumike/screens/Homescreen/my_bookmark_page/my_bookmark_page.dart';
// import 'package:edumike/screens/Homescreen/my_course_page/my_course_page.dart';
// import 'package:edumike/screens/Homescreen/profiles_page/profiles_page.dart';
// import 'package:edumike/widgets/app_bar/appbar_leading_image_home.dart';
// import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
// import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
// import 'package:edumike/widgets/custom_bottom_bar.dart';
// import 'package:flutter/material.dart';

// // ignore_for_file: must_be_immutable
// class SubscriptionScreen extends StatelessWidget {
//   SubscriptionScreen({Key? key}) : super(key: key);

//   GlobalKey<NavigatorState> navigatorKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             appBar: _buildAppBar(context),
//             body: Container(
//                 width: double.maxFinite,
//                 padding: EdgeInsets.symmetric(horizontal: 34.h, vertical: 25.v),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("University",
//                           style: CustomTextStyles.titleMediumBold),
//                       SizedBox(height: 17.v),
//                       _buildViewHierarchy(context)
//                     ])),
//             bottomNavigationBar: _buildBottomBar(context)));
//   }

//   /// Section Widget
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//         leadingWidth: 61.h,
//         leading: AppbarLeadingImage(
//             imagePath: ImageConstant.imgArrowDown,
//             margin: EdgeInsets.only(left: 35.h, top: 17.v, bottom: 18.v),
//             onTap: () {
//               onTapArrowDown(context);
//             }),
//         title: AppbarSubtitle(
//             text: "Subscription", margin: EdgeInsets.only(left: 12.h)));
//   }

//   /// Section Widget
//   Widget _buildViewHierarchy(BuildContext context) {
//     return ListView.separated(
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         separatorBuilder: (context, index) {
//           return SizedBox(height: 12.v);
//         },
//         itemCount: 3,
//         itemBuilder: (context, index) {
//           return ViewhierarchyItemWidget(onTapTxtSubscribeText: () {
//             onTapTxtSubscribeText(context);
//           });
//         });
//   }

//   /// Section Widget
//   Widget _buildBottomBar(BuildContext context) {
//     return CustomBottomBar(onChanged: (BottomBarEnum type) {
//       Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
//     });
//   }

//   ///Handling route based on bottom click actions
//   String getCurrentRoute(BottomBarEnum type) {
//     switch (type) {
//       case BottomBarEnum.Home:
//         return AppRoutes.homemainpagePage;
//       case BottomBarEnum.Mycourses:
//         return AppRoutes.myCoursePage;
//       case BottomBarEnum.Indox:
//         return AppRoutes.indoxmainpagePage;
//       case BottomBarEnum.Bookmark:
//         return AppRoutes.myBookmarkPage;
//       case BottomBarEnum.Profile:
//         return AppRoutes.profilesPage;
//       default:
//         return "/";
//     }
//   }

//   ///Handling page based on route
//   Widget getCurrentPage(String currentRoute) {
//     switch (currentRoute) {
//       case AppRoutes.homemainpagePage:
//         return HomemainpagePage();
//       case AppRoutes.myCoursePage:
//         return MyCoursePage();
//       case AppRoutes.indoxmainpagePage:
//         return IndoxmainpagePage();
//       case AppRoutes.myBookmarkPage:
//         return MyBookmarkPage();
//       case AppRoutes.profilesPage:
//         return ProfilesPage();
//       default:
//         return DefaultWidget();
//     }
//   }

//   /// Navigates to the addSubscribeScreen when the action is triggered.
//   onTapTxtSubscribeText(BuildContext context) {
//     Navigator.pushNamed(context, AppRoutes.addSubscribeScreen);
//   }

//   /// Navigates to the homemainpageContainerScreen when the action is triggered.
//   onTapArrowDown(BuildContext context) {
//     Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
//   }
// }
