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
// import 'package:edumike/widgets/custom_search_view_home.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class SearchScreen extends StatelessWidget {
//   SearchScreen({Key? key})
//       : super(
//           key: key,
//         );

//   TextEditingController searchController = TextEditingController();

//   GlobalKey<NavigatorState> navigatorKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: _buildAppBar(context),
//         body: Container(
//           width: double.maxFinite,
//           padding: EdgeInsets.symmetric(
//             horizontal: 34.h,
//             vertical: 3.v,
//           ),
//           child: Column(
//             children: [
//               CustomSearchView(
//                 controller: searchController,
//                 hintText: "Graphic Design",
//               ),
//               SizedBox(height: 29.v),
//               _buildHeading(context),
//               SizedBox(height: 30.v),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 1.h),
//                 child: _buildGraphicDesign(
//                   context,
//                   dynamicText: "3D Design",
//                   dynamicText1: "X",
//                 ),
//               ),
//               SizedBox(height: 28.v),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 1.h),
//                 child: _buildGraphicDesign(
//                   context,
//                   dynamicText: "Graphic Design",
//                   dynamicText1: "X",
//                 ),
//               ),
//               SizedBox(height: 28.v),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 1.h),
//                 child: _buildGraphicDesign(
//                   context,
//                   dynamicText: "Programming",
//                   dynamicText1: "X",
//                 ),
//               ),
//               SizedBox(height: 28.v),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 1.h),
//                 child: _buildGraphicDesign(
//                   context,
//                   dynamicText: "SEO & Marketing",
//                   dynamicText1: "X",
//                 ),
//               ),
//               SizedBox(height: 28.v),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 1.h),
//                 child: _buildGraphicDesign(
//                   context,
//                   dynamicText: "Web Development",
//                   dynamicText1: "X",
//                 ),
//               ),
//               SizedBox(height: 28.v),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 1.h),
//                 child: _buildGraphicDesign(
//                   context,
//                   dynamicText: "Office Productivity",
//                   dynamicText1: "X",
//                 ),
//               ),
//               SizedBox(height: 28.v),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 1.h),
//                 child: _buildGraphicDesign(
//                   context,
//                   dynamicText: "Personal Development",
//                   dynamicText1: "X",
//                 ),
//               ),
//               SizedBox(height: 28.v),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 1.h),
//                 child: _buildGraphicDesign(
//                   context,
//                   dynamicText: "Finance & Accounting",
//                   dynamicText1: "X",
//                 ),
//               ),
//               SizedBox(height: 28.v),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 1.h),
//                 child: _buildGraphicDesign(
//                   context,
//                   dynamicText: "HR Management",
//                   dynamicText1: "X",
//                 ),
//               ),
//               SizedBox(height: 5.v),
//             ],
//           ),
//         ),
//         bottomNavigationBar: _buildBottomBar(context),
//       ),
//     );
//   }

//   /// Section Widget
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//       leadingWidth: 61.h,
//       leading: AppbarLeadingImage(
//         imagePath: ImageConstant.imgArrowDown,
//         margin: EdgeInsets.only(
//           left: 35.h,
//           top: 18.v,
//           bottom: 17.v,
//         ),
//       ),
//       title: AppbarSubtitle(
//         text: "Search",
//         margin: EdgeInsets.only(left: 12.h),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildHeading(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(right: 1.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "Recents Search",
//             style: CustomTextStyles.titleSmallJostBluegray90001,
//           ),
//           Spacer(),
//           Padding(
//             padding: EdgeInsets.only(
//               top: 3.v,
//               bottom: 2.v,
//             ),
//             child: Text(
//               "See All".toUpperCase(),
//               style: CustomTextStyles.labelLargeMulishPrimary,
//             ),
//           ),
//           CustomImageView(
//             imagePath: ImageConstant.imgArrowRightPrimary,
//             height: 10.v,
//             width: 5.h,
//             margin: EdgeInsets.only(
//               left: 10.h,
//               top: 5.v,
//               bottom: 6.v,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildBottomBar(BuildContext context) {
//     return CustomBottomBar(
//       onChanged: (BottomBarEnum type) {
//         Navigator.pushNamed(
//             navigatorKey.currentContext!, getCurrentRoute(type));
//       },
//     );
//   }

//   /// Common widget
//   Widget _buildGraphicDesign(
//     BuildContext context, {
//     required String dynamicText,
//     required String dynamicText1,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(top: 1.v),
//           child: Text(
//             dynamicText,
//             style: CustomTextStyles.titleSmallGray50015.copyWith(
//               color: appTheme.gray500,
//             ),
//           ),
//         ),
//         Text(
//           dynamicText1,
//           style: CustomTextStyles.titleSmallGray80001.copyWith(
//             color: appTheme.gray80001,
//           ),
//         ),
//       ],
//     );
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
// }
