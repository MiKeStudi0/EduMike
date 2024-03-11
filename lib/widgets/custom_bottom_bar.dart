// import 'package:edumike/core/app_export.dart';
// import 'package:edumike/screens/Dropdownlist.dart';
// import 'package:edumike/screens/Homescreen/my_course_page/my_course_page.dart';
// import 'package:edumike/screens/Homescreen/profiles_page/profiles_page.dart';
// import 'package:flutter/material.dart';

// import '../screens/Homescreen/homemainpage_page/homemainpage_page.dart';

// // ignore: must_be_immutable
// class CustomBottomBar extends StatefulWidget {
//   CustomBottomBar({this.onChanged});

//   Function(BottomBarEnum)? onChanged;

//   @override
//   CustomBottomBarState createState() => CustomBottomBarState();
// }

// class CustomBottomBarState extends State<CustomBottomBar> {
//   int selectedIndex = 0;

//   List<BottomMenuModel> bottomMenuList = [
//     BottomMenuModel(
//       icon: ImageConstant.imgNavHomeNot,
//       activeIcon: ImageConstant.imgNavHome,
//       title: "Home".toUpperCase(),
//       type: BottomBarEnum.Home,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavMyCourses,
//       activeIcon: ImageConstant.imgNavMyCoursesActive,
//       title: "My Courses".toUpperCase(),
//       type: BottomBarEnum.Mycourses,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavIndox,
//       activeIcon: ImageConstant.imgNavIndoxActive,
//       title: "Indox".toUpperCase(),
//       type: BottomBarEnum.Indox,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavBookMark,
//       activeIcon: ImageConstant.imgNavBookMarkActive,
//       title: "Book Mark".toUpperCase(),
//       type: BottomBarEnum.Bookmark,
//     ),
//     BottomMenuModel(
//       icon: ImageConstant.imgNavProfile,
//       activeIcon: ImageConstant.imgNavProfileActive,
//       title: "Profile".toUpperCase(),
//       type: BottomBarEnum.Profile,
//     )
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100.v,
//       decoration: BoxDecoration(
//         color: appTheme.gray5001,
//       ),
//       child: BottomNavigationBar(
//         backgroundColor: Colors.transparent,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         selectedFontSize: 0,
//         elevation: 0,
//         currentIndex: selectedIndex,
//         type: BottomNavigationBarType.fixed,
//         items: List.generate(bottomMenuList.length, (index) {
//           return BottomNavigationBarItem(
//             icon: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CustomImageView(
//                   imagePath: bottomMenuList[index].icon,
//                   height: 20.v,
//                   width: 18.h,
//                   color: appTheme.blueGray90001,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 4.v),
//                   child: Text(
//                     bottomMenuList[index].title ?? "",
//                     style: theme.textTheme.labelSmall!.copyWith(
//                       color: appTheme.blueGray90001,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             activeIcon: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CustomImageView(
//                   imagePath: bottomMenuList[index].activeIcon,
//                   height: 19.v,
//                   width: 18.h,
//                   color: theme.colorScheme.primary,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 5.v),
//                   child: Text(
//                     bottomMenuList[index].title ?? "",
//                     style: CustomTextStyles.labelSmallPrimary.copyWith(
//                       color: theme.colorScheme.primary,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             label: '',
//           );
//         }),
//         onTap: (index) {
//           selectedIndex = index;
//           widget.onChanged?.call(bottomMenuList[index].type);
//           setState(() {});
//         },
//       ),
//     );
//   }
// }

// enum BottomBarEnum {
//   Home,
//   Mycourses,
//   Indox,
//   Bookmark,
//   Profile,
// }

// class BottomMenuModel {
//   BottomMenuModel({
//     required this.icon,
//     required this.activeIcon,
//     this.title,
//     required this.type,
//   });

//   String icon;

//   String activeIcon;

//   String? title;

//   BottomBarEnum type;
// }

// class DefaultWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.all(10),
//       child: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Please replace the respective Widget here',
//               style: TextStyle(
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HomemainpageContainerScreen extends StatelessWidget {
//   HomemainpageContainerScreen({Key? key}) : super(key: key);

//   GlobalKey<NavigatorState> navigatorKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: appTheme.whiteA700,
//         body: SingleChildScrollView(
//           physics: NeverScrollableScrollPhysics(),
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//             child: Navigator(
//               key: navigatorKey,
//               initialRoute: AppRoutes.homemainpagePage,
//               onGenerateRoute: (routeSetting) => PageRouteBuilder(
//                 pageBuilder: (ctx, ani, ani1) =>
//                     getCurrentPage(routeSetting.name!),
//                 transitionDuration: Duration(seconds: 0),
//               ),
//             ),
//           ),
//         ),
//         bottomNavigationBar: CustomBottomBar(),
//       ),
//     );
//   }

//   String getCurrentRoute(BottomBarEnum type) {
//     switch (type) {
//       case BottomBarEnum.Home:
//         return AppRoutes.homemainpagePage;
//       case BottomBarEnum.Mycourses:
//         return AppRoutes.myCoursePage;
//       case BottomBarEnum.Indox:
//         return AppRoutes.uploadscreen;
//       case BottomBarEnum.Bookmark:
//         return AppRoutes.listview;
//       case BottomBarEnum.Profile:
//         return AppRoutes.profilesPage;
//       default:
//         return "/";
//     }
//   }

//   Widget getCurrentPage(String currentRoute) {
//     switch (currentRoute) {
//       case AppRoutes.homemainpagePage:
//         return HomemainpagePage();
//       case AppRoutes.myCoursePage:
//         return MyCoursePage();
//       case AppRoutes.uploadscreen:
//         return UploadDataPage();
//       case AppRoutes.listview:
//         return FirestoreListView();
//       case AppRoutes.profilesPage:
//         return ProfilesPage();
//       default:
//         return DefaultWidget();
//     }
//   }
// }
