import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/Homescreen/cgpa_calculator_screen/option_screen.dart';
import 'package:edumike/screens/Homescreen/modules_screen/modules_screen.dart';
import 'package:edumike/screens/Homescreen/modules_screen/syllabus.dart';
import 'package:edumike/screens/Homescreen/upload_screen/upload_notes_screen.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_search_view_home.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class CategoryScreen extends StatelessWidget {
  final String? university;
  final String? degree;
  final String? course;
  final String? semester;
  final String? courseName;

  CategoryScreen({super.key, 
    this.university,
    this.degree,
    this.course,
    this.semester,
    this.courseName,
  });
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.gray5002,
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 16.v),
                    child: Container(
                        margin: EdgeInsets.only(bottom: 5.v),
                        padding: EdgeInsets.symmetric(horizontal: 34.h),
                        child: Column(children: [
                          CustomSearchView(
                              controller: searchController,
                              hintText: "Search for..",
                              contentPadding: EdgeInsets.only(
                                  left: 20.h, top: 21.v, bottom: 21.v)),
                          SizedBox(height: 57.v),
                          Padding(
                              padding: EdgeInsets.only(left: 55.h, right: 47.h),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomImageView(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Syllabus(
                                                                university:
                                                                    university!,
                                                                degree: degree!,
                                                                course: course!,
                                                                semester:
                                                                    semester!,
                                                                courseName:
                                                                    courseName!,
                                                                category:
                                                                    "Syllabus")));
                                              },
                                              imagePath:
                                                  ImageConstant.imgSyllabus,
                                              height: 53.adaptSize,
                                              width: 53.adaptSize),
                                          SizedBox(height: 6.v),
                                          Text("Syllabus",
                                              style: CustomTextStyles
                                                  .titleSmallBluegray90001_1)
                                        ]),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ModulesScreen(
                                                    university: university,
                                                    degree: degree,
                                                    course: course,
                                                    semester: semester,
                                                    courseName: courseName,
                                                    category: 'Notes',
                                                  )),
                                        );
                                      },
                                      child: _buildcolumn(context,
                                          televisionImage:
                                              ImageConstant.imgNotes,
                                          result: "Notes"),
                                    )
                                  ])),
                          SizedBox(height: 69.v),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 52.h, right: 31.h),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ModulesScreen(
                                                          university:
                                                              university,
                                                          degree: degree,
                                                          course: course,
                                                          semester: semester,
                                                          courseName:
                                                              courseName,
                                                          category: 'Text Book',
                                                        )));
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 2.v, bottom: 1.v),
                                              child: Column(children: [
                                                CustomImageView(
                                                    imagePath: ImageConstant
                                                        .imgTextbook,
                                                    height: 53.adaptSize,
                                                    width: 53.adaptSize),
                                                SizedBox(height: 8.v),
                                                Text("Text Book",
                                                    style: CustomTextStyles
                                                        .titleSmallBluegray90001_1)
                                              ])),
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomImageView(
                                                  imagePath: ImageConstant
                                                      .imgQuestionBank,
                                                  height: 53.adaptSize,
                                                  width: 53.adaptSize,
                                                  margin: EdgeInsets.only(
                                                      left: 19.h),
                                                  onTap: () {
                                                    onTapImgQuestionBank(
                                                        context);
                                                  }),
                                              SizedBox(height: 12.v),
                                              Text("Question Bank",
                                                  style: CustomTextStyles
                                                      .titleSmallBluegray90001_1)
                                            ])
                                      ]))),
                          SizedBox(height: 60.v),
                          Padding(
                              padding: EdgeInsets.only(left: 32.h, right: 15.h),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      // onTap: () {
                                      //       Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   UploadScreen()));},
                                      child: Padding(
                                          padding: EdgeInsets.only(top: 1.v),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomImageView(
                                                    imagePath: ImageConstant
                                                        .imgQuestionPaper,
                                                    height: 53.adaptSize,
                                                    width: 53.adaptSize,
                                                    margin: EdgeInsets.only(
                                                        left: 22.h)),
                                                SizedBox(height: 14.v),
                                                Text("Question Paper",
                                                    style: CustomTextStyles
                                                        .titleSmallBluegray90001_1)
                                              ])),
                                    ),
                                    Column(children: [
                                      CustomImageView(
                                          imagePath:
                                              ImageConstant.imgAcademicCalender,
                                          height: 53.adaptSize,
                                          width: 53.adaptSize),
                                      SizedBox(height: 13.v),
                                      Text("Academic Calendar",
                                          style: CustomTextStyles
                                              .titleSmallBluegray90001_1)
                                    ])
                                  ])),
                          SizedBox(height: 58.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 53.h),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          onTapSeven(context);
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 9.v),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomImageView(
                                                      imagePath: ImageConstant
                                                          .imgContact,
                                                      height: 53.adaptSize,
                                                      width: 53.adaptSize,
                                                      alignment: Alignment
                                                          .centerRight),
                                                  SizedBox(height: 13.v),
                                                  Text("Contact",
                                                      style: CustomTextStyles
                                                          .titleSmallBluegray90001_1)
                                                ]))),
                                    _buildcolumn(context,
                                        televisionImage:
                                            ImageConstant.imgTelevisionBlue600,
                                        result: "Result")
                                  ])),
                          SizedBox(height: 55.v),
                          Padding(
                              padding: EdgeInsets.only(left: 52.h, right: 57.h),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 2.v, bottom: 1.v),
                                        child: Column(children: [
                                          CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgComputer,
                                              height: 44.v,
                                              width: 61.h),
                                          SizedBox(height: 15.v),
                                          Text("Code",
                                              style: CustomTextStyles
                                                  .titleSmallBluegray90001_1)
                                        ])),
                                    Column(children: [
                                      CustomImageView(
                                          imagePath: ImageConstant.imgWebsite,
                                          height: 53.adaptSize,
                                          width: 53.adaptSize),
                                      SizedBox(height: 9.v),
                                      Text("Website",
                                          style: CustomTextStyles
                                              .titleSmallBluegray90001_1)
                                    ])
                                  ])),
                          SizedBox(height: 50.v),
                          Padding(
                              padding: EdgeInsets.only(left: 39.h, right: 29.h),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 9.v),
                                        child: Column(children: [
                                          CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgCreditSystem,
                                              height: 53.adaptSize,
                                              width: 53.adaptSize),
                                          Text("Credit System",
                                              style: CustomTextStyles
                                                  .titleSmallBluegray90001_1)
                                        ])),
                                    Column(children: [
                                      GestureDetector(
                                        onTap: (){
                                           Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                           const GPAHomePage()));
                                        },
                                        child: CustomImageView(
                                            imagePath: ImageConstant.imgCgpaCal,
                                            height: 53.adaptSize,
                                            width: 53.adaptSize),
                                      ),
                                      SizedBox(height: 4.v),
                                      Text("CGPA Calculator",
                                          style: CustomTextStyles
                                              .titleSmallBluegray90001_1)
                                    ])
                                  ])),
                          SizedBox(height: 46.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 39.h),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(children: [
                                      Container(
                                        child: GestureDetector(
                                          child: CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgUploadnotes,
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const EmailServicePage()));
                                              },
                                              height: 53.adaptSize,
                                              width: 53.adaptSize,
                                              alignment: Alignment.centerRight,
                                              margin:
                                                  EdgeInsets.only(right: 12.h)),
                                        ),
                                      ),
                                      SizedBox(height: 9.v),
                                      Text("Upload Notes",
                                          style: CustomTextStyles
                                              .titleSmallBluegray90001_1)
                                    ]),
                                    Column(children: [
                                      CustomImageView(
                                          imagePath:
                                              ImageConstant.imgExamtimetable,
                                          height: 53.adaptSize,
                                          width: 53.adaptSize),
                                      SizedBox(height: 7.v),
                                      Text("Exam Table",
                                          style: CustomTextStyles
                                              .titleSmallBluegray90001_1)
                                    ])
                                  ])),
                          SizedBox(height: 38.v),
                          CustomImageView(
                              imagePath: ImageConstant.imgFaq,
                              height: 53.adaptSize,
                              width: 53.adaptSize,
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 66.h)),
                          SizedBox(height: 6.v),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 78.h),
                                  child: Text("FAQ",
                                      style: CustomTextStyles
                                          .titleSmallBluegray90001_1)))
                        ]))))));
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
            text: "All Category", margin: EdgeInsets.only(left: 12.h)));
  }

  /// Common widget
  Widget _buildcolumn(
    BuildContext context, {
    required String televisionImage,
    required String result,
  }) {
    return Column(children: [
      CustomImageView(imagePath: televisionImage, height: 60.v, width: 53.h),
      SizedBox(height: 14.v),
      Text(result,
          style: CustomTextStyles.titleSmallBluegray90001_1
              .copyWith(color: appTheme.blueGray90001.withOpacity(0.8)))
    ]);
  }

  /// Navigates to the modulesScreen when the action is triggered.
  onTapResultColumn(BuildContext context) {
    print('Result tapped');
    // Navigator.pushNamed(context, AppRoutes.modulesScreen);
  }

  /// Navigates to the modulesScreen when the action is triggered.
  onTapImgQuestionBank(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.modulesScreen);
  }

  /// Navigates to the helpcareScreen when the action is triggered.
  onTapSeven(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.helpcareScreen);
  }
}
