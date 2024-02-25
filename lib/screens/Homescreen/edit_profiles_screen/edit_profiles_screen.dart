import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/screens/loginscreen/fill_your_profile_screen.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_elevated_button.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:edumike/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




// ignore: must_be_immutable
class EditProfilesScreen extends StatefulWidget {
  
  EditProfilesScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<EditProfilesScreen> createState() => _EditProfilesScreenState();
}

class _EditProfilesScreenState extends State<EditProfilesScreen> {
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
  /*await userDocRef.update({
    'fullname': fullNameController,
    'nickname': nameController.text,
    'dateofbirth': dateOfBirthController.text,
    'email': emailController.text,
    'gender': genderController,
    'phone': phoneNumberController.text,
    // Add other fields as needed
  });}*/

  
 

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('91');


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 10.v),
            child: Container(
              margin: EdgeInsets.only(
                left: 34.h,
                right: 34.h,
                bottom: 5.v,
              ),
              decoration: AppDecoration.fillGray,
              child: Column(
                children: [
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
                  SizedBox(height: 40.v),
                  _buildFullName(context),
                  SizedBox(height: 18.v),
                  _buildName(context),
                  SizedBox(height: 18.v),
                  _buildDateOfBirth(context),
                  SizedBox(height: 18.v),
                  _buildEmail(context),
                  SizedBox(height: 18.v),
                  _buildPhoneNumber(context),
                  SizedBox(height: 18.v),
                   _buildgender(context),
                  SizedBox(height: 18.v),
                  _buildUpdateButton(),
                  SizedBox(height: 10.v),
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
      leadingWidth: 61.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDown,
        margin: EdgeInsets.only(
          left: 35.h,
          top: 18.v,
          bottom: 17.v,
        ),
      ),
      title: AppbarSubtitle(
        text: "Edit Profile",
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }

  /// Section Widget
 /*Widget _buildFullName(BuildContext context) {
  // Get the current user
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    // User is not authenticated, handle accordingly
    return Text('User not authenticated');
  }

  return StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Return a loading indicator while data is being fetched
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // Handle error
        return Text('Error: ${snapshot.error}');
      } else {
        // Extract the full name from the snapshot data
        String fullName = snapshot.data?.get('fullname') ?? ''; // Replace 'full_name' with the actual field name in your Firestore document

        // Initialize the controller with the full name
        fullNameController.text = fullName;

        // Return the CustomTextFormField with the initialized controller
        return CustomTextFormField(
          controller: fullNameController,
          hintText: "Full Name",
        );
      }
    },
  );
}*/


Widget _buildFullName(BuildContext context) {
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
          onChanged: (value) {
            // Update the value of the controller when text changes
            fullNameController.text = value;
          },
        );
      }
    },
  );
}


/*Widget _buildfullName(BuildContext context) {
    return CustomTextFormField(
      controller: fullNameController,
      hintText: "full Name",
    );
  }*/
  Widget _buildName(BuildContext context) {
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
        );
      }
    },
  );
}

  /// Section Widget
  /*Widget _buildName(BuildContext context) {
    return CustomTextFormField(
      controller: nameController,
      hintText: "Nick Name",
    );
  }*/
  Widget _buildDateOfBirth(BuildContext context) {
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
        );
      }
    },
  );
}

  /// Section Widget
  /*Widget _buildDateOfBirth(BuildContext context) {
    return CustomTextFormField(
      controller: dateOfBirthController,
      hintText: "Date of Birth",
      prefix: Container(
        margin: EdgeInsets.fromLTRB(21.h, 20.v, 8.h, 20.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgCalendar,
          height: 20.v,
          width: 18.h,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 60.v,
      ),
      contentPadding: EdgeInsets.only(
        top: 21.v,
        right: 30.h,
        bottom: 21.v,
      ),
    );
  }*/

  Widget _buildEmail(BuildContext context) {
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
        );
      }
    },
  );
}

  /// Section Widget
  /*Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: emailController,
      hintText: "Email",
      textInputType: TextInputType.emailAddress,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(20.h, 23.v, 7.h, 22.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgLockSecondarycontainer,
          height: 14.v,
          width: 18.h,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 60.v,
      ),
      contentPadding: EdgeInsets.only(
        top: 21.v,
        right: 30.h,
        bottom: 21.v,
      ),
    );
  }*/

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
        );
      }
    },
  );
}

  /// Section Widget
  /*Widget _buildPhoneNumber(BuildContext context) {
    return CustomPhoneNumber(
      country: selectedCountry,
      controller: phoneNumberController,
      onTap: (Country value) {
        selectedCountry = value;
      },
    );
  }*/

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
        );
      }
    },
  );
}

  /// Section Widget
  /*Widget _buildColumn(BuildContext context) {
    return Container(
      width: 360.h,
      padding: EdgeInsets.symmetric(
        horizontal: 22.h,
        vertical: 20.v,
      ),
      decoration: AppDecoration.outlineBlack900.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Text(
        "Student",
        style: CustomTextStyles.titleSmallGray800,
      ),
    );
  }*/

  /// Section Widget
  /*Widget _buildButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Update",
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      rightIcon: Container(
        padding: EdgeInsets.fromLTRB(14.h, 16.v, 12.h, 14.v),
        margin: EdgeInsets.only(left: 30.h),
        decoration: BoxDecoration(
          color: appTheme.whiteA700,
          borderRadius: BorderRadius.circular(
            24.h,
          ),
        ),
        child: CustomImageView(
          imagePath: ImageConstant.imgArrowrightPrimary17x21,
          height: 17.v,
          width: 21.h,
        ),
      ),
    );
  }
}*/
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

}
