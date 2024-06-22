import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/Homescreen/homemainpage_page/homemainpage_page.dart';
import 'package:edumike/screens/Homescreen/my_bookmark_page/my_bookmark_page.dart';
import 'package:edumike/screens/Homescreen/my_course_page/my_course_page.dart';
import 'package:edumike/screens/Homescreen/profiles_page/profiles_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomemainpageContainerScreen extends StatefulWidget {
  final String? university;
  final String? degree;
  final String? course;
  final String? semester;

  const HomemainpageContainerScreen({super.key, 
    this.university,
    this.degree,
    this.course,
    this.semester,
  });

  @override
  State<HomemainpageContainerScreen> createState() =>
      _HomemainpageContainerScreenState();
}

class _HomemainpageContainerScreenState
    extends State<HomemainpageContainerScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  int _currentIndex = 0;

  String? selecteduniversity;

  String? selecteddegree;

  String? selectedcourse;

  String? selectedsemester;

  List<String> bookmarkedCourses = [];

  Future<Map<String, String?>?> getCardData() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the "carddata" collection
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('carddata')
                .doc(user.uid)
                .get();

        // Check if the document exists
        if (snapshot.exists) {
          // Extract field values from the document data
          selecteduniversity = snapshot.data()?['university'];
          selecteddegree = snapshot.data()?['degree'];
          selectedcourse = snapshot.data()?['course'];
          selectedsemester = snapshot.data()?['semester'];

          // Print the values for debugging
          print('Selected University: $selecteduniversity');
          print('Selected Degree: $selecteddegree');
          print('Selected Course: $selectedcourse');
          print('Selected Semester: $selectedsemester');

          // Return the card data as a map
          return {
            'university': selecteduniversity,
            'degree': selecteddegree,
            'course': selectedcourse,
            'semester': selectedsemester,
          };
        } else {
          // Return null if the document doesn't exist
          print('Document does not exist');
          return null;
        }
      } else {
        // Handle case when the user is not authenticated
        print('User not authenticated');
        return null;
      }
    } catch (e) {
      // Print an error message if an error occurs
      print('Error retrieving card data: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    // Fetch card data and print it for debugging
    getCardData().then((cardData) {
      print('Card Data: $cardData');

      // Update the state with the fetched data if not null
      if (cardData != null) {
        setState(() {
          selecteduniversity = cardData['university'];
          selecteddegree = cardData['degree'];
          selectedcourse = cardData['course'];
          selectedsemester = cardData['semester'];
        });
      }
    });
  }

  final navigationkey = GlobalKey<CurvedNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    print('university: $selecteduniversity');
    print('degree: $selecteddegree');
    print('course: $selectedcourse');
    print('semester: $selectedsemester');

    final screens = [
      const HomemainpagePage(),
      MyCoursePage(
        university: selecteduniversity,
        degree: selecteddegree,
        course: selectedcourse,
        semester: selectedsemester,
      ),
      // IndoxmainpagePage(),
      MyBookmarkPage(university: selecteduniversity,
        degree: selecteddegree,
        course: selectedcourse,
        semester: selectedsemester,),
      const ProfilesPage(),
    ];
    String imagePathHome = 'assets/images/home_image';
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Visibility(
        visible: !isKeyboardOpen,
        child: CurvedNavigationBar(
          buttonBackgroundColor: const Color.fromARGB(255, 59, 131, 255),
          items: <Widget>[
            _buildIcon(0, 'assets/images/home_image/HomeScreen.svg',
                '$imagePathHome/img_nav_homeNot.svg'),
            _buildIcon(1, '$imagePathHome/CourseScreen.svg',
                '$imagePathHome/img_nav_my_courses.svg'),
            // _buildIcon(2, '$imagePathHome/IndoxScreen.svg',
            //     '$imagePathHome/img_nav_indox.svg'),
            _buildIcon(2, '$imagePathHome/BookmarkScreen.svg',
                '$imagePathHome/img_nav_book_mark.svg'),
            _buildIcon(3, '$imagePathHome/ProfileScreen.svg',
                '$imagePathHome/img_nav_profile.svg'),
          ],
          backgroundColor: Colors.transparent,
          color: const Color.fromARGB(255, 60, 118, 218),
          height: 75,
          index: _currentIndex,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
          key: navigationkey,
        ),
      ),
      backgroundColor: appTheme.whiteA700,
      body: PopScope(
        child: screens[_currentIndex],
        onPopInvoked: (bool popInvoked) {
          // Your existing logic
          if (_currentIndex != 0 && popInvoked) {
            setState(() {
              _currentIndex = 0;
            });
          }
        },
      ),
    );
  }

  Widget _buildBody() {
    final screens = [
      const HomemainpagePage(),
      MyCoursePage(
        university: selecteduniversity,
        degree: selecteddegree,
        course: selectedcourse,
        semester: selectedsemester,
      ),
      // IndoxmainpagePage(),
      MyBookmarkPage( university: selecteduniversity,
        degree: selecteddegree,
        course: selectedcourse,
        semester: selectedsemester,),
      const ProfilesPage(),
    ];
    return screens[_currentIndex];
  }

  Widget _buildNavigationBar() {
    String imagePathHome = 'assets/images/home_image';
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(75), // Adjust the height as needed
          child: _buildNavigationBar(),
        ),
      ),
      body: _buildBody(),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Visibility(
        child: CurvedNavigationBar(
          buttonBackgroundColor: const Color.fromARGB(255, 59, 131, 255),
          items: <Widget>[
            _buildIcon(0, 'assets/images/home_image/HomeScreen.svg',
                '$imagePathHome/img_nav_homeNot.svg'),
            _buildIcon(1, '$imagePathHome/CourseScreen.svg',
                '$imagePathHome/img_nav_my_courses.svg'),
            // _buildIcon(2, '$imagePathHome/IndoxScreen.svg',
            //     '$imagePathHome/img_nav_indox.svg'),
            _buildIcon(3, '$imagePathHome/BookmarkScreen.svg',
                '$imagePathHome/img_nav_book_mark.svg'),
            _buildIcon(4, '$imagePathHome/ProfileScreen.svg',
                '$imagePathHome/img_nav_profile.svg'),
          ],
          backgroundColor: Colors.transparent,
          color: const Color.fromARGB(255, 60, 118, 218),
          height: 75,
          index: _currentIndex,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
          key: navigationkey,
        ),
      ),
      backgroundColor: appTheme.whiteA700,
    );
  }

  Widget _buildIcon(int index, String selectedImage, String unselectedImage) {
    return SizedBox(
      height: 25,
      width: 25,
      child: SvgPicture.asset(
        _currentIndex == index ? selectedImage : unselectedImage,
        fit: BoxFit.contain,
      ),
    );
  }
}
