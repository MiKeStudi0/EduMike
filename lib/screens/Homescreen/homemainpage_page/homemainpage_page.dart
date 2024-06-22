import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/screens/Homescreen/add_university_card_screen/add_university_card_screen.dart';
import 'package:edumike/screens/Homescreen/homemainpage_page/widgets/test.dart';
import 'package:edumike/screens/Homescreen/indoxmainpage_page/indoxmainpage_page.dart';
import 'package:edumike/screens/Homescreen/my_course_page/my_course_page.dart';
import 'package:edumike/screens/Homescreen/search_screen/dummy.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:edumike/widgets/app_bar/appbar_title_home.dart';
import 'package:edumike/widgets/app_bar/appbar_trailing_iconbutton_home.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class HomemainpagePage extends StatefulWidget {
  const HomemainpagePage({super.key});

  @override
  State<HomemainpagePage> createState() => _HomemainpagePageState();
}

class _HomemainpagePageState extends State<HomemainpagePage>
    with AutomaticKeepAliveClientMixin {
  String? university;

  String? degree;

  String? course;

  String? semester;

  TextEditingController searchController = TextEditingController();

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocument() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User not authenticated');
    }

    return await FirebaseFirestore.instance
        .collection(
            'users') // Replace 'users' with the name of your root collection
        .doc(user.uid)
        .collection(
            'carddata') // Replace 'carddata' with the name of your sub-collection
        .doc(user.uid)
        .get();
  }

  Widget carddata(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: getUserDocument(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the data to load, show a loading indicator
          return _buildUniversityCard1(
              context, university, degree, course, semester);
        } else if (snapshot.hasError) {
          // If an error occurs while fetching the data, show the error message
          return Text('Error: ${snapshot.error}');
        } else {
          // If the data is successfully fetched, extract the values
          university = snapshot.data?.data()?['university'];
          degree = snapshot.data?.data()?['degree'];
          course = snapshot.data?.data()?['course'];
          semester = snapshot.data?.data()?['semester'];

          if (university == null ||
              degree == null ||
              course == null ||
              semester == null) {
            return _buildUniversityCard1(
                context, university, degree, course, semester);
          }

          // Call _buildUniversityCard with the retrieved values
          return _buildUniversityCard(
              context, university, degree, course, semester);
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 43.v),
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34.h),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return FractionallySizedBox(
                                heightFactor: 0.90,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: SearchCourse(
                                    university: university!,
                                    degree: degree!,
                                    course: course!,
                                    semester: semester!,
                                  ),
                                ),
                              );
                            },
                            backgroundColor: Colors.transparent,
                          );
                        },
                        child: Container(
                          width: 414.h,
                          height: 50.v,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blue, Colors.lightBlueAccent],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: const Offset(
                                    0, 5), // Adjust the vertical offset
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              SizedBox(
                                  width:
                                      8), // Add some space between icon and text
                              Text(
                                "Search Courses",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  SizedBox(height: 30.v),
                  carddata(context),
                  SizedBox(height: 29.v),

                  // _buildUserCourse(context),
                  Padding(
                      padding: EdgeInsets.only(left: 18.h, right: 50.h),
                      child: _buildTopMentor(context,
                          text: "My Courses", seeAll: "See All")),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        left: 10.v,
                      ),
                      child: const CourseListBlock()),
                  SizedBox(height: 15.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 79.v,
      title: FutureBuilder<String?>(
        future: getNickname(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            String nickname = snapshot.data ?? 'BOSS';
            return Padding(
              padding: EdgeInsets.only(left: 35.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppbarTitle(
                    text: "Hi, $nickname",
                    margin: EdgeInsets.only(right: 129.h),
                  ),
                  SizedBox(height: 3.v),
                  AppbarSubtitleOne(
                    text: "What Would you like to learn Today? Search Below.",
                  ),
                ],
              ),
            );
          }
        },
      ),
      actions: [
        GestureDetector(
          onTap: () => onTapMessage(context),
          child: CustomImageView(
            imagePath: ImageConstant.imgNavIndoxPrimary,
            height: 35.h,
            width: 35.v,
            margin: EdgeInsets.fromLTRB(0, 10.v, 20.h, 13.v),
          ),
        ),
        AppbarTrailNotification(
          imagePath: ImageConstant.imgNotification,
          margin: EdgeInsets.fromLTRB(0.h, 16.v, 14.h, 13.v),
          onTap: () {
            onTapThumbsUp(context);
          },
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildUniversityCard(
    BuildContext context,
    String? university,
    String? degree,
    String? course,
    String? semester,
  ) {
    return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyle.roundedBorder22),
        child: Container(
            height: 180.v,
            width: 360.h,
            decoration: AppDecoration.fillPrimary
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder22),
            child: Stack(alignment: Alignment.topLeft, children: [
              CustomImageView(
                  imagePath: ImageConstant.imgPath2,
                  height: 76.v,
                  width: 181.h,
                  alignment: Alignment.bottomRight),
              CustomImageView(
                  imagePath: ImageConstant.imgPath3,
                  height: 72.v,
                  width: 156.h,
                  alignment: Alignment.topLeft),
              CustomImageView(
                  imagePath: ImageConstant.imgArrowLeft,
                  height: 28.v,
                  width: 21.h,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 158.h)),
              CustomImageView(
                  imagePath: ImageConstant.imgCardEdit,
                  height: 33.adaptSize,
                  width: 33.adaptSize,
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 13.v, right: 15.h),
                  onTap: () {
                    _showBottomSheet(context);
                  }),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding:
                          EdgeInsets.only(left: 18.h, top: 13.v, right: 92.h),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 22.h),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(bottom: 3.v),
                                          child: Text("Selected ",
                                              style: CustomTextStyles
                                                  .titleLargeMulishAmberA200)),
                                      const Spacer(),
                                      CustomImageView(
                                          imagePath: ImageConstant
                                              .imgArrowLeftBlueA40001,
                                          height: 19.v,
                                          width: 14.h,
                                          margin: EdgeInsets.only(top: 11.v)),
                                      Container(
                                          height: 10.v,
                                          width: 40.h,
                                          margin: EdgeInsets.only(
                                              left: 29.h,
                                              top: 17.v,
                                              bottom: 3.v),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.h),
                                              border: Border.all(
                                                  color: appTheme.blueA40001,
                                                  width: 2.h,
                                                  strokeAlign:
                                                      strokeAlignCenter)))
                                    ])),
                            SizedBox(height: 1.v),
                            SizedBox(
                                height: 38.v,
                                width: 360.h,
                                child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      CustomImageView(
                                          imagePath: ImageConstant.imgTriangle,
                                          height: 8.adaptSize,
                                          width: 8.adaptSize,
                                          alignment: Alignment.bottomRight,
                                          margin: EdgeInsets.only(right: 62.h)),
                                      Align(
                                          alignment: Alignment.topCenter,
                                          child: SizedBox(
                                              width: 248.h,
                                              child: Text(
                                                  "Recommendation & Materials Based on Your Selected Course .!",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: CustomTextStyles
                                                      .labelLargeMulishGray200)))
                                    ])),
                            SizedBox(height: 7.v),
                            Row(
                              children: [
                                SizedBox(
                                  width: 150.h,
                                  child: Text(
                                    university!.toUpperCase(),
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomTextStyles.titleSmallWhiteA700,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 38.h),
                                  child: SizedBox(
                                    width: 60.h,
                                    child: Text(
                                      degree!.toUpperCase(),
                                      overflow: TextOverflow.fade,
                                      style:
                                          CustomTextStyles.titleSmallWhiteA700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 13.v),
                            Padding(
                              padding: EdgeInsets.only(right: 38.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150.h,
                                    child: Text(
                                      course!.toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          CustomTextStyles.titleSmallWhiteA700,
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Text(
                                          semester!.toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          style: CustomTextStyles
                                              .titleSmallWhiteA700,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ])))
            ])));
  }

  Widget _buildUniversityCard1(
    BuildContext context,
    String? university,
    String? degree,
    String? course,
    String? semester,
  ) {
    return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        color: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyle.roundedBorder22),
        child: Container(
            height: 180.v,
            width: 360.h,
            decoration: AppDecoration.fillPrimary
                .copyWith(borderRadius: BorderRadiusStyle.roundedBorder22),
            child: Stack(alignment: Alignment.topLeft, children: [
              CustomImageView(
                  imagePath: ImageConstant.imgPath2,
                  height: 76.v,
                  width: 181.h,
                  alignment: Alignment.bottomRight),
              CustomImageView(
                  imagePath: ImageConstant.imgPath3,
                  height: 72.v,
                  width: 156.h,
                  alignment: Alignment.topLeft),
              CustomImageView(
                  imagePath: ImageConstant.imgArrowLeft,
                  height: 28.v,
                  width: 21.h,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 158.h)),
              CustomImageView(
                  imagePath: ImageConstant.imgCardEdit,
                  height: 33.adaptSize,
                  width: 33.adaptSize,
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 13.v, right: 15.h),
                  onTap: () {
                    _showBottomSheet(context);
                  }),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding:
                          EdgeInsets.only(left: 18.h, top: 13.v, right: 92.h),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 22.h),
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(bottom: 3.v),
                                          child: Text("Selected ",
                                              style: CustomTextStyles
                                                  .titleLargeMulishAmberA200)),
                                      const Spacer(),
                                      CustomImageView(
                                          imagePath: ImageConstant
                                              .imgArrowLeftBlueA40001,
                                          height: 19.v,
                                          width: 14.h,
                                          margin: EdgeInsets.only(top: 11.v)),
                                      Container(
                                          height: 10.v,
                                          width: 40.h,
                                          margin: EdgeInsets.only(
                                              left: 29.h,
                                              top: 17.v,
                                              bottom: 3.v),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.h),
                                              border: Border.all(
                                                  color: appTheme.blueA40001,
                                                  width: 2.h,
                                                  strokeAlign:
                                                      strokeAlignCenter)))
                                    ])),
                            SizedBox(height: 1.v),
                            SizedBox(
                                height: 38.v,
                                width: 248.h,
                                child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      CustomImageView(
                                          imagePath: ImageConstant.imgTriangle,
                                          height: 8.adaptSize,
                                          width: 8.adaptSize,
                                          alignment: Alignment.bottomRight,
                                          margin: EdgeInsets.only(right: 62.h)),
                                      Align(
                                          alignment: Alignment.topCenter,
                                          child: SizedBox(
                                              width: 248.h,
                                              child: Text(
                                                  "Recommendation & Materials Based on Your Selected Course .!",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: CustomTextStyles
                                                      .labelLargeMulishGray200)))
                                    ])),
                            SizedBox(height: 7.v),
                            Row(children: [
                              Text("university".toUpperCase(),
                                  style: CustomTextStyles.titleSmallWhiteA700),
                              Padding(
                                  padding: EdgeInsets.only(left: 38.h),
                                  child: Text("degree".toUpperCase(),
                                      style:
                                          CustomTextStyles.titleSmallWhiteA700))
                            ]),
                            SizedBox(height: 13.v),
                            Padding(
                                padding: EdgeInsets.only(right: 38.h),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("course".toUpperCase(),
                                          style: CustomTextStyles
                                              .titleSmallWhiteA700),
                                      Text("semester".toUpperCase(),
                                          style: CustomTextStyles
                                              .titleSmallWhiteA700)
                                    ]))
                          ])))
            ])));
  }

  /// popup varunnath
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(18.0)),
          child: FractionallySizedBox(
            heightFactor: 0.87,
            child: SizedBox(
              // Set a specific height, you can adjust this value based on your needs
              height: MediaQuery.of(context).size.height * 0.87,
              child: const AddUniversityCardScreen(),
            ),
          ),
        );
      },
    );
  }

  /// Common widget
  Widget _buildTopMentor(
    BuildContext context, {
    required String text,
    required String seeAll,
  }) {
    return Row(children: [
      Text(text,
          style: CustomTextStyles.titleMedium18
              .copyWith(color: appTheme.blueGray90001)),
      const Spacer(),
      GestureDetector(
          onTap: () {
            onTapTxtSeeAll(context);
          },
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.v),
              child: Text(seeAll,
                  style: CustomTextStyles.labelLargeMulishPrimary
                      .copyWith(color: theme.colorScheme.primary)))),
      CustomImageView(
          imagePath: ImageConstant.imgArrowRightPrimary,
          height: 10.v,
          width: 5.h,
          margin: EdgeInsets.only(left: 10.h, top: 7.v, bottom: 9.v))
    ]);
  }

  /// Navigates to the appNotificationsScreen when the action is triggered.
  onTapThumbsUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.appNotificationsScreen);
  }

  /// Navigates to the appNotificationsScreen when the action is triggered.
  onTapMessage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const IndoxmainpagePage()));
  }

  /// Navigates to the categoryScreen when the action is triggered.
  onTapOne(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.categoryScreen);
  }

  /// Navigates to the subscriptionScreen when the action is triggered.
  onTapTxtSeeAll(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyCoursePage(
                  university: university, // Pass the actual values here
                  degree: degree,
                  course: course,
                  semester: semester,
                )));
  }

  /// Navigates to the categoryScreen when the action is triggered.
  onTapTxtGraphicDesign(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.categoryScreen);
  }

  Future<String?> getNickname(String userId) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    return userData['nickname'];
  }
}
