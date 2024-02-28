import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:flutter/material.dart';

class Bookmark {
  final String category;
  final String title;
  final String description;
  final double rating;
  final int numberOfStudents;

  Bookmark({
    required this.category,
    required this.title,
    required this.description,
    required this.rating,
    required this.numberOfStudents,
  });
}

class MyBookmarkPage extends StatefulWidget {
  const MyBookmarkPage({Key? key}) : super(key: key);

  @override
  _MyBookmarkPageState createState() => _MyBookmarkPageState();
}

class _MyBookmarkPageState extends State<MyBookmarkPage> {
  List<Bookmark> bookmarks = [];
  List<String> categories = ['Syllabus', 'Notes'];
  String selectedCategory = 'Syllabus';

  @override
  void initState() {
    super.initState();
    initializeData();
    _buildFilterChips(); 
  }

  Future<void> initializeData() async {
    await Future.delayed(Duration(seconds: 0));

    setState(() {
      bookmarks = [
        Bookmark(
          category: 'Syllabus',
          title: 'Computer Network...',
          description: 'Description..',
          rating: 4.2,
          numberOfStudents: 7830,
        ),
        // Add more bookmarks as needed
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredBookmarks = bookmarks.where((bookmark) {
      return selectedCategory.isEmpty || selectedCategory == bookmark.category;
    }).toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray5001,
        appBar: _buildAppBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterChips(),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16.v);
                },
                itemCount: filteredBookmarks.length,
                itemBuilder: (context, index) {
                  final bookmark = filteredBookmarks[index];
                  return _buildBookmarkItem(bookmark);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
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
                      selectedCategory = selected ? category : '';
                    });
                  },
                  selectedColor: selectedCategory.isEmpty
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primary,
                  labelStyle: TextStyle(
                    color: selectedCategory == category ? Colors.white : null,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildBookmarkItem(Bookmark bookmark) {
    return Container(
      margin: EdgeInsets.only(left: 20.h, right: 20.h, bottom: 20.v),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage,
            height: 130.adaptSize,
            width: 130.adaptSize,
            radius: BorderRadius.horizontal(
              left: Radius.circular(20.h),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 14.h, top: 15.v, bottom: 18.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 195.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bookmark.category,
                        style: CustomTextStyles.labelLargeMulishOrangeA700,
                      ),
                      SizedBox(
                        height: 16.v,
                        width: 12.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgBookmarkPrimary,
                              height: 16.v,
                              width: 12.h,
                              alignment: Alignment.center,
                              onTap: () {},
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgBookmarkPrimary,
                              height: 16.v,
                              width: 12.h,
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.v),
                Text(
                  bookmark.title,
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 5.v),
                Text(
                  bookmark.description,
                  style: theme.textTheme.titleSmall,
                ),
                SizedBox(height: 5.v),
                Row(
                  children: [
                    Container(
                      width: 32.h,
                      margin: EdgeInsets.only(top: 3.v),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgSignal,
                            height: 11.v,
                            width: 12.h,
                            margin: EdgeInsets.only(bottom: 2.v),
                          ),
                          Text(
                            bookmark.rating.toString(),
                            style: theme.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.h),
                      child: Text(
                        "|",
                        style: CustomTextStyles.titleSmallBlack900,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.h, top: 3.v),
                      child: Text(
                        bookmark.numberOfStudents.toString() + " Std",
                        style: theme.textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 61.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDown,
        margin: EdgeInsets.only(left: 35.h, top: 17.v, bottom: 18.v),
      ),
      title: AppbarSubtitle(
        text: "My Bookmark",
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }
}
