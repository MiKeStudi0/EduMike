import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class Course {
  final String courseName;
  final String category;
  final String courseCode;
  final String courseCredit;

  Course({
    required this.courseName,
    required this.category,
    required this.courseCode,
    required this.courseCredit,
  });
}

final List<Course> courseList = [
  Course(
      courseName: 'Flutter',
      category: 'Syllabus',
      courseCode: 'CSE 101',
      courseCredit: '3.0'),
  Course(
      courseName: 'Django',
      category: 'Notes',
      courseCode: 'CSE 102',
      courseCredit: '3.0'),
  Course(
      courseName: 'Laravel',
      category: 'Notes',
      courseCode: 'CSE 103',
      courseCredit: '3.0'),
  Course(
      courseName: 'React',
      category: 'Notes',
      courseCode: 'CSE 104',
      courseCredit: '3.0'),
  Course(
      courseName: 'Vue',
      category: 'Notes',
      courseCode: 'CSE 105',
      courseCredit: '3.0'),
  Course(
      courseName: 'Angular',
      category: 'Notes',
      courseCode: 'CSE 106',
      courseCredit: '3.0'),
  Course(
      courseName: 'Swift',
      category: 'Syllabus',
      courseCode: 'CSE 107',
      courseCredit: '3.0'),
  Course(
      courseName: 'Kotlin',
      category: 'Syllabus',
      courseCode: 'CSE 108',
      courseCredit: '3.0'),
  Course(
      courseName: 'Rust',
      category: 'Syllabus',
      courseCode: 'CSE 109',
      courseCredit: '3.0'),
  Course(
      courseName: 'Dart',
      category: 'Syllabus',
      courseCode: 'CSE 110',
      courseCredit: '3.0'),
  Course(
      courseName: 'JavaScript',
      category: 'Notes',
      courseCode: 'CSE 111',
      courseCredit: '3.0'),
  Course(
      courseName: 'TypeScript',
      category: 'Notes',
      courseCode: 'CSE 112',
      courseCredit: '3.0'),
  Course(
      courseName: 'PHP',
      category: 'Notes',
      courseCode: 'CSE 113',
      courseCredit: '3.0'),
  Course(
      courseName: 'HTML',
      category: 'Notes',
      courseCode: 'CSE 114',
      courseCredit: '3.0'),
  Course(
      courseName: 'CSS',
      category: 'Notes',
      courseCode: 'CSE 115',
      courseCredit: '3.0'),
  Course(
      courseName: 'SQL',
      category: 'Notes',
      courseCode: 'CSE 116',
      courseCredit: '3.0'),
  Course(
      courseName: 'MongoDB',
      category: 'Notes',
      courseCode: 'CSE 117',
      courseCredit: '3.0'),
  Course(
      courseName: 'Firebase',
      category: 'Notes',
      courseCode: 'CSE 118',
      courseCredit: '3.0'),
  Course(
      courseName: 'PostgreSQL',
      category: 'Notes',
      courseCode: 'CSE 119',
      courseCredit: '3.0'),
];

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  final List<String> categories = ['Syllabus', 'Notes'];
  String selectedCategory = 'Syllabus';

  @override
  Widget build(BuildContext context) {
    final filteredCourses = courseList.where((course) {
      return selectedCategory.isEmpty || selectedCategory == course.category;
    }).toList();

    return SizedBox(
      height: 340.v,
      width: 400.h,
      child: Column(
        children: [
          // Filter Widget in the Body
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories
                  .map(
                    (category) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilterChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = selected ? category : 'Syllabus';
                          });
                        },
                        selectedColor: selectedCategory == 'Syllabus' ||
                                selectedCategory == 'Notes'
                            ? appTheme.blueA700
                            : null,
                        labelStyle: TextStyle(
                          color: selectedCategory == category
                              ? Colors.white
                              : null,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          // Course List
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                final course = filteredCourses[index];
                return _buildCourseList(context, course);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseList(BuildContext context, Course course) {
    return SizedBox(
      height: 240.v,
      width: 280.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 240,
            width: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 134,
                width: 280,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 19),
                child: SizedBox(
                  width: 245,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 1),
                        child: Text(
                          course.category,
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      // Replace this with your bookmark icon
                      Icon(Icons.bookmark),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 14),
                child: Text(course.courseName),
              ),
              SizedBox(height: 9),
              Padding(
                padding: EdgeInsets.only(left: 13),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      margin: EdgeInsets.only(top: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Replace this with your signal icon
                          CustomImageView(
                            imagePath: ImageConstant.imgSignal,
                            height: 11.v,
                            width: 12.h,
                            margin: EdgeInsets.only(bottom: 2.v),
                          ),
                          Text(course.courseCredit),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text("|"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 3),
                      child: Text(course.courseCode),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
