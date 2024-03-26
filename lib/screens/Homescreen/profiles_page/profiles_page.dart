import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/Homescreen/app_notifications_screen/app_notifications_screen.dart';
import 'package:edumike/screens/Homescreen/edit_profiles_screen/edit_profiles_screen.dart';
import 'package:edumike/screens/Homescreen/helpcenter_screen/helpcenter.dart';
import 'package:edumike/screens/Homescreen/invite_friends_screen/invite_friends_screen.dart';
import 'package:edumike/screens/Homescreen/security_screen/security_page.dart';
import 'package:edumike/screens/Homescreen/terms_conditions_screen/terms_conditions_screen.dart';
import 'package:edumike/screens/loginscreen/fill_your_profile_screen.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image_home.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilesPage extends StatefulWidget {
  ProfilesPage({Key? key}) : super(key: key);

  @override
  State<ProfilesPage> createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  final user = FirebaseAuth.instance.currentUser!;
  String? profileUrl;
  String? nickname;
  String? email;

 void initState() {
    super.initState();
    // Check if user data exists locally, if not then fetch from Firestore
    checkLocalUserData();
  }


   Future<void> checkLocalUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userDataExists = prefs.getBool('userDataExists') ?? false;

    if (userDataExists) {
      // User data exists locally, fetch it from SharedPreferences
      setState(() {
        profileUrl = prefs.getString('profileUrl');
        nickname = prefs.getString('nickname');
        email = prefs.getString('email');
      });
    } else {
      // Fetch user data from Firestore
      getUserData();
    }
  }

 Future<void> getUserData() async {
    try {
      // Get reference to the document for the current user
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Retrieve data from the document
      setState(() {
        profileUrl = userData['profileUrl'];
        nickname = userData['nickname'];
        email = userData['email'];
      });

      // Store fetched data locally
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('userDataExists', true);
      await prefs.setString('profileUrl', profileUrl ?? '');
      await prefs.setString('nickname', nickname ?? '');
      await prefs.setString('email', email ?? '');
    } catch (error) {
      print('Error retrieving user data: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 27.v),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 28.h),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 93.v,
                                  width: 89.h,
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: appTheme
                                                .teal700, // Set border color here
                                            width: 4, // Set border width here
                                          ),
                                        ),
                                        child: const CircleAvatar(
                                          radius: 64,
                                          //backgroundImage: ,
                                          // Add child here if needed
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: appTheme
                                                .blue600, // Set border color here
                                            width: 4, // Set border width here
                                          ),
                                        ),
                                        child: InstaImageViewer(
                                          child: CircleAvatar(
                                            radius: 64,
                                            child: ClipOval(
                                              child: profileUrl != null
                                                  ? Image.network(
                                                      profileUrl!,
                                                      width: 370,
                                                      height: 370,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset("assets/images/EduWise.jpg"), // Show loading indicator if profileUrl is null
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Padding(
                                      //     padding: EdgeInsets.only(right: 3.h),
                                      //     child: CustomIconButton(
                                      //         height: 29.adaptSize,
                                      //         width: 29.adaptSize,
                                      //         padding: EdgeInsets.all(6.h),
                                      //        // decoration: IconButtonStyleHelper
                                      //          //   .outlineTeal,
                                      //         alignment: Alignment.bottomRight,
                                      //         child: Icon(Icons.edit,
                                      //             size: 15.adaptSize,
                                      //             color: appTheme
                                      //                 .blue600))) // Add child here if needed
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 7.v),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          'Welcome, ${nickname ?? "loading..."}',
                                          style: theme.textTheme.headlineSmall),
                                      const SizedBox(height: 8),
                                      Text('${email ?? "loading..."}',
                                          style: theme.textTheme.titleSmall),
                                    ],
                                  ),
                                ],
                              ),

                              /* Align(
                                  alignment: Alignment.center,
                                  child: Text("Alex",
                                      style: theme.textTheme.headlineSmall)),
                              SizedBox(height: 5.v),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text("hernandex.redial@gmail.ac.in",
                                      style: CustomTextStyles
                                          .labelLargeMulishSecondaryContainerBold)),*/
                              SizedBox(height: 45.v),
                              _buildOne(context),
                              SizedBox(height: 42.v),
                              _buildTwo(context),
                              SizedBox(height: 42.v),
                              _buildThree(context),
                              SizedBox(height: 43.v),
                              _buildFour(context),
                              SizedBox(height: 43.v),
                              _buildFive(context),
                              SizedBox(height: 44.v),
                              _buildSix(context),
                              SizedBox(height: 43.v),
                              _buildSeven(context),
                              SizedBox(height: 40.v),
                              _buildEight(context),
                              SizedBox(height: 43.v),
                              _buildNine(context),
                              SizedBox(height: 44.v),
                              GestureDetector(
                                  onTap: () {
                                    signUserOut(context);
                                  },
                                  child: _buildTen(context)),
                              SizedBox(height: 44.v),
                            ]))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 61.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowDown,
            margin: EdgeInsets.only(left: 35.h, top: 18.v, bottom: 18.v),
            onTap: () {
              onTapBack(context);
            }),
        title: AppbarSubtitle(
            text: "Profile", margin: EdgeInsets.only(left: 12.h)));
  }

  /// Section Widget
 Widget _buildOne(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => EditProfilesScreen()));
    },
    child: Container(
       color: const Color.fromARGB(255, 255, 255, 255), // Set background color to blue
      child: Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgSettings,
              height: 23.v,
              width: 18.h,
            ),
            SizedBox(width: 16.h),
            Expanded(
              child: Row(
                children: [
                  Text(
                    "Edit Profile",
                    style: CustomTextStyles.titleSmallBluegray9000115,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgArrowRight,
                    height: 21.v,
                    width: 12.h,
                    margin: EdgeInsets.only(top: 2.v, left: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  /// Section Widget
  Widget _buildTwo(BuildContext context) {
    return GestureDetector(
      onTap: (){
        ontapten(context);
      },
      child: Padding(
          padding: EdgeInsets.only(left: 20.h),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            CustomImageView(
                imagePath: ImageConstant.paymentOption,
                height: 22.22.v,
                width: 23.39.h),
            Padding(
                padding: EdgeInsets.only(left: 11.h, top: 3.v),
                child: Text("Payment Option",
                    style: CustomTextStyles.titleSmallBluegray9000115)),
            const Spacer(),
          ])),
    );
  }

  /// Section Widget
  Widget _buildThree(BuildContext context) {
  return GestureDetector(
    onTap: () {
      // Your onTap function logic here
      onTapTwo(context);
    },
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 20.h,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgUserBlueGray90001,
                  height: 23.v,
                  width: 19.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.h, top: 2.v, bottom: 2.v),
                  child: Text(
                    "Notifications",
                    style: CustomTextStyles.titleSmallBluegray9000115,
                  ),
                ),
              ],
            ),
            CustomImageView(
              imagePath: ImageConstant.imgArrowRight,
              height: 11.v,
              width: 12.h,
              margin: EdgeInsets.only(top: 2.v),
            ),
          ],
        ),
      ),
    ),
  );
}


  /// Section Widget
  Widget _buildFour(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapThree(context);
        
      },
      child: Container(
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.only(left: 19.h),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              CustomImageView(
                  imagePath: ImageConstant.imgTelevisionBlueGray90001,
                  height: 23.adaptSize,
                  width: 23.adaptSize),
              Padding(
                  padding: EdgeInsets.only(left: 12.h, bottom: 2.v),
                  child: Text("Security",
                      style: CustomTextStyles.titleSmallBluegray9000115)),
              const Spacer(),
              CustomImageView(
                  imagePath: ImageConstant.imgArrowRight, height: 21.v, width: 12.h)
            ])),
      ),
    );
  }

  /// Section Widget
  Widget _buildFive(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomImageView(
              imagePath: ImageConstant.imgCloseGray900,
              height: 21.v,
              width: 23.h),
          Padding(
              padding: EdgeInsets.only(left: 11.h, top: 2.v),
              child: Text("Language",
                  style: CustomTextStyles.titleSmallBluegray9000115)),
          const Spacer(),
          Padding(
              padding: EdgeInsets.only(top: 3.v),
              child: Text("English (US)",
                  style: CustomTextStyles.titleSmallPrimaryExtraBold)),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRight,
              height: 21.v,
              width: 12.h,
              margin: EdgeInsets.only(left: 17.h))
        ]));
  }

  /// Section Widget
  Widget _buildSix(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomImageView(
              imagePath: ImageConstant.imgEye,
              height: 16.v,
              width: 25.h,
              margin: EdgeInsets.only(bottom: 3.v)),
          Padding(
              padding: EdgeInsets.only(left: 9.h, bottom: 2.v),
              child: Text("Dark Mode",
                  style: CustomTextStyles.titleSmallBluegray9000115)),
          const Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRight, height: 21.v, width: 12.h)
        ]));
  }

  /// Section Widget
  Widget _buildSeven(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTapSeven(context);
        },
        child: Container(
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.only(left: 22.h),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                CustomImageView(
                    imagePath: ImageConstant.imgUserBlueGray9000121x18,
                    height: 21.v,
                    width: 18.h),
                Padding(
                    padding: EdgeInsets.only(left: 14.h, bottom: 2.v),
                    child: Text("Terms & Conditions",
                        style: CustomTextStyles.titleSmallBluegray9000115)),
                const Spacer(),
                CustomImageView(
                    imagePath: ImageConstant.imgArrowRight,
                    height: 21.v,
                    width: 12.h)
              ])),
        ));
  }

  /// Section Widget
  Widget _buildEight(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapEight(context);
      },
      child: Container(
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.only(left: 19.h),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              CustomImageView(
                  imagePath: ImageConstant.imgProfile,
                  height: 26.adaptSize,
                  width: 26.adaptSize),
              Padding(
                  padding: EdgeInsets.only(left: 9.h, top: 4.v, bottom: 3.v),
                  child: Text("Help Center",
                      style: CustomTextStyles.titleSmallBluegray9000115)),
              CustomImageView(
                  imagePath: ImageConstant.imgArrowRight,
                  height: 21.v,
                  width: 12.h,
                  margin: EdgeInsets.only(top: 4.v)),
              const Spacer(),
            ])),
      ),
    );
  }

  /// Section Widget
  Widget _buildNine(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTapNine(context);
        },
        child: Container(
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 1.v),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImageView(
                                  imagePath: ImageConstant.imgFill1Onprimary,
                                  height: 21.v,
                                  width: 23.h),
                              Padding(
                                  padding: EdgeInsets.only(left: 11.h),
                                  child: Text("Invite Friends",
                                      style: CustomTextStyles
                                          .titleSmallBluegray9000115))
                            ])),
                    CustomImageView(
                        imagePath: ImageConstant.imgArrowRight,
                        height: 21.v,
                        width: 12.h)
                  ])),
        ));
  }

  /// Section Widget
  Widget _buildTen(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomImageView(
              imagePath: ImageConstant.imgClock, height: 19.v, width: 20.h),
          Padding(
              padding: EdgeInsets.only(left: 14.h),
              child: Text("Logout",
                  style: CustomTextStyles.titleSmallBluegray9000115)),
          const Spacer(),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRight, height: 21.v, width: 12.h)
        ]));
  }

  void signUserOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, AppRoutes.letSYouInScreen);
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  /// Navigates to the editProfilesScreen when the action is triggered.
  onTapOne(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => EditProfilesScreen()));
  }

  onTapThree(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecurityScreen()));
  }


  /// Navigates to the termsConditionsScreen when the action is triggered.
  onTapSeven(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const TermsConditionsScreen()));
  }

   onTapEight(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HelpFeedbackPage()));
  }

  /// Navigates to the inviteFriendsScreen when the action is triggered.
  onTapNine(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  InviteFriendsScreen()));
  }
  ontapten(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  FillYourProfileScreen()));
  }

  onTapTwo(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) =>  AppNotificationsScreen()));
  }
  onTapBack(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
  }
}
