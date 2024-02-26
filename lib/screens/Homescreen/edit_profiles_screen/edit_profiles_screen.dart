import 'package:edumike/screens/loginscreen/fill_your_profile_screen.dart';
import 'package:edumike/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image.dart';
import 'package:edumike/widgets/app_bar/appbar_title.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:edumike/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EditProfilesScreen());
}
 
// ignore_for_file: must_be_immutable
class EditProfilesScreen extends StatefulWidget {
  EditProfilesScreen({Key? key}) : super(key: key);

  @override
  State<EditProfilesScreen> createState() => _FillYourProfileScreenState();
}

class _FillYourProfileScreenState extends State<EditProfilesScreen> {
  TextEditingController fullNameEditTextController = TextEditingController();
  late final String gendervalue;
  // DateTime _picked=DateTime.now();

  

  FocusNode emailFocusNode = FocusNode();

  FocusNode dateofbirthFocusNode = FocusNode();

  FocusNode fullnameFocusNode = FocusNode();

  FocusNode nicknameFocusNode = FocusNode();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController emailController = TextEditingController();

    TextEditingController genderController = TextEditingController();
      TextEditingController phoneNumberController = TextEditingController();

  Future<void> updateUserData() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('User not authenticated');
  }

  String userId = user.uid;

  // Replace 'users' with your Firestore collection name
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Replace the field names and values as per your data structure
  await userCollection.doc(userId).set({
    'fullname': fullNameController.text,
    'nickname': nameController.text,
    'dateofbirth': dateOfBirthController.text,
    'email': emailController.text,
    'gender': genderController.text,
     'phone': phoneNumberController.text,
  });}


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: Container(
                          color: appTheme.blue50,
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 34.h, vertical: 29.v),
                            child: Column(children: [
                              SizedBox(
                    height: 94.v,
                    width: 93.h,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 93.adaptSize,
                            width: 93.adaptSize,
                            decoration: BoxDecoration(
                              color: appTheme.whiteA700,
                              borderRadius: BorderRadius.circular(
                                46.h,
                              ),
                              border: Border.all(
                                color: appTheme.teal700,
                                width: 3.h,
                                strokeAlign: strokeAlignOutside,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 9.h),
                          child: CustomIconButton(
                            height: 33.adaptSize,
                            width: 33.adaptSize,
                            padding: EdgeInsets.all(7.h),
                            decoration: IconButtonStyleHelper.outlineTeal,
                            alignment: Alignment.bottomRight,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgTelevisionTeal700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                              SizedBox(height: 30.v),
                              _buildFullNameEditText(context),
                              SizedBox(height: 20.v),
                              _buildNameEditText(context),
                              SizedBox(height: 20.v),
                              _buildDateOfBirthEditText(context),
                              SizedBox(height: 20.v),
                              _buildEmailEditText(context),
                              SizedBox(height: 20.v),
                              _buildPhoneNumber(context),
                              SizedBox(height: 20.v),
                              _buildgender(context),
                              SizedBox(height: 20.v),
                              _buildUpdateButton(),
                              SizedBox(height: 5.v)
                            ])))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
 backgroundColor: appTheme.blue50,    leadingWidth: 61.h,
    leading: AppbarLeadingImage(
      imagePath: ImageConstant.imgArrowDown,
      margin: EdgeInsets.only(left: 35.h, top: 18.v, bottom: 17.v),
    ),
    title: AppbarTitle(
      text: "Edit Your Profile",
      margin: EdgeInsets.only(left: 12.h),
    ),
  );
}


  /// Section Widget
  Widget _buildFullNameEditText(BuildContext context) {
  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDocument(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the data to load, show a loading indicator
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If an error occurs while fetching the data, show the error message
        return Text('Error: ${snapshot.error}');
      } else {
        // If the data is successfully fetched, extract the full name
        String? fullName = snapshot.data?.data()?['fullname'];

        if (fullName == null) {
          // If full name is null, handle the case accordingly
          return Text('Full name not found');
        }

        // Set the initial value of the fullNameController
        fullNameController.text = fullName;

        // Return the CustomTextFormField with onChanged callback to update the controller
        return CustomTextFormField(
          controller: fullNameController,
          hintText: "Full Name",
          contentPadding: EdgeInsets.only(left: 16.0,top: 35), // Adjust the left padding as needed
        );
      }
    },
  );
}


  /// Section Widget
  Widget _buildNameEditText(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDocument(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the data to load, show a loading indicator
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If an error occurs while fetching the data, show the error message
        return Text('Error: ${snapshot.error}');
      } else {
        // If the data is successfully fetched, extract the full name
        String? nickName = snapshot.data?.data()?['nickname'];

        if (nickName == null) {
          // If full name is null, handle the case accordingly
          return Text('nick name not found');
        }

        // Create a TextEditingController and set its initial value to the full name
        nameController.text = nickName;

        // Return the CustomTextFormField with the initialized controller
        return CustomTextFormField(
          controller: nameController,
          hintText: "nick Name",
          contentPadding: EdgeInsets.only(left: 16.0,top: 35), 
        );
      }
    },
  );
}

  /// Section Widget
  Widget _buildDateOfBirthEditText(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDocument(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the data to load, show a loading indicator
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If an error occurs while fetching the data, show the error message
        return Text('Error: ${snapshot.error}');
      } else {
        // If the data is successfully fetched, extract the full name
        String? dob = snapshot.data?.data()?['dateofbirth'];

        if (dob == null) {
          // If full name is null, handle the case accordingly
          return Text('dob not found');
        }

        // Create a TextEditingController and set its initial value to the full name
        dateOfBirthController.text = dob;

        // Return the CustomTextFormField with the initialized controller
        return CustomTextFormField(
          controller: dateOfBirthController,
          hintText: " dateofbirth",
          contentPadding: EdgeInsets.only(left: 16.0,top: 35), 
        );
      }
    },
  );
}

  /// Section Widget
  Widget _buildEmailEditText(BuildContext context) {
   return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDocument(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the data to load, show a loading indicator
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If an error occurs while fetching the data, show the error message
        return Text('Error: ${snapshot.error}');
      } else {
        // If the data is successfully fetched, extract the full name
        String? email = snapshot.data?.data()?['email'];

        if (email == null) {
          // If full name is null, handle the case accordingly
          return Text('email not found');
        }

        // Create a TextEditingController and set its initial value to the full name
        emailController.text = email;

        // Return the CustomTextFormField with the initialized controller
        return CustomTextFormField(
          controller: emailController,
          hintText: " email",
          contentPadding: EdgeInsets.only(left: 16.0,top: 35), 
        );
      }
    },
  );
}

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
   return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDocument(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the data to load, show a loading indicator
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If an error occurs while fetching the data, show the error message
        return Text('Error: ${snapshot.error}');
      } else {
        // If the data is successfully fetched, extract the full name
        String? phone = snapshot.data?.data()?['phone'];

        if (phone == null) {
          // If full name is null, handle the case accordingly
          return Text('phone not found');
        }

        // Create a TextEditingController and set its initial value to the full name
        phoneNumberController.text = phone;

        // Return the CustomTextFormField with the initialized controller
        return CustomTextFormField(
          controller: phoneNumberController,
          hintText: " phone",
          contentPadding: EdgeInsets.only(left: 16.0,top: 35),
        );
      }
    },
  );
}

Widget _buildgender(BuildContext context) {
  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDocument(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the data to load, show a loading indicator
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If an error occurs while fetching the data, show the error message
        return Text('Error: ${snapshot.error}');
      } else {
        // If the data is successfully fetched, extract the full name
        String? gender= snapshot.data?.data()?['gender'];

        if (gender == null) {
          // If full name is null, handle the case accordingly
          return Text('gender not found');
        }

        // Create a TextEditingController and set its initial value to the full name
        genderController.text = gender;

        // Return the CustomTextFormField with the initialized controller
        return CustomTextFormField(
          controller: genderController,
          hintText: "gender ",
          contentPadding: EdgeInsets.only(left: 16.0,top: 35),
        );
      }
    },
  );
}

  /// Section Widget
  Widget _buildUpdateButton() {
  return CustomElevatedButton(
    text: "Update",
    margin: EdgeInsets.symmetric(horizontal: 5.h),
    rightIcon: Container(
      padding: EdgeInsets.fromLTRB(14.h, 16.v, 12.h, 14.v),
      margin: EdgeInsets.only(left: 30.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(24.h),
      ),
      child: CustomImageView(
        imagePath: ImageConstant.imgArrowrightPrimary17x21,
        height: 17.v,
        width: 21.h,
      ),
    ),
    onPressed: () {
      updateUserData();
    },
  );
}

  /// Navigates to the congratulationsScreen when the action is triggered.
  
    // Use the user ID as the document ID
    
  }

