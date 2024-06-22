import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/Homescreen/category_screen/category_screen.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class SelectedviewItemWidget extends StatelessWidget {
  final String courseCredit;
  final String university;
  final String degree;
  final String course;
  final String semester;
  final String courseName;
  final String courseCode;

  const SelectedviewItemWidget({
    super.key,
    required this.courseCredit,
    required this.courseName,
    required this.courseCode,
    required this.university,
    required this.degree,
    required this.course,
    required this.semester,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              university: university,
              degree: degree,
              course: course,
              semester: semester,
              courseName: courseName,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 16.h,
          top: 19.v,
          bottom: 19.v,
        ),
        decoration: AppDecoration.outlineBlueGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder18,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 1.v),
              child: CustomIconButton(
                height: 52.adaptSize,
                width: 52.adaptSize,
                padding: EdgeInsets.all(16.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgTelevisionBlack900,
                ),
              ),
            ),
            const SizedBox(width: 10), // Add some spacing between the icon and text
            Expanded(
              // Use Expanded to allow the text to occupy remaining space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseName, // Use courseName here
                    style: CustomTextStyles.titleMedium19,
                  ),
                  SizedBox(height: 6.v),
                  Text(
                    courseCode,
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ), // Add some spacing between the text and bookmark icon
          ],
        ),
      ),
    );
  }


  
}