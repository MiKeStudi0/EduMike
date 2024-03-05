import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image.dart';
import 'package:edumike/widgets/app_bar/appbar_title.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:edumike/widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';

// ignore_for_file: must_be_immutable
class EditProfilesScreen extends StatefulWidget {
  EditProfilesScreen({Key? key}) : super(key: key);

  @override
  State<EditProfilesScreen> createState() => _FillYourProfileScreenState();
}

class _FillYourProfileScreenState extends State<EditProfilesScreen> {
  
  TextEditingController fullnameEditTextController = TextEditingController();
  late final String gendervalue;

  FocusNode emailFocusNode = FocusNode();

  FocusNode dateofbirthFocusNode = FocusNode();

  FocusNode fullnameFocusNode = FocusNode();

  FocusNode nicknameFocusNode = FocusNode();

  TextEditingController fullnameController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController genderController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  late DocumentSnapshot _userSnapshot;
 
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getUserData();
  }

   Future<void> _getUserData() async {
    try {
      _user = _auth.currentUser!;
      _userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .get();

      // Fetch the profile image URL
      String? profileImageUrl = _userSnapshot['profileUrl'];

      // Update the state with the existing image URL
      setState(() {
        fullnameController.text = _userSnapshot['fullname'] ?? '';
        nameController.text = _userSnapshot['nickname'] ?? '';
        dateOfBirthController.text = _userSnapshot['dateofbirth'] ?? '';
        emailController.text = _userSnapshot['email'] ?? '';
        phoneNumberController.text = _userSnapshot['phone'] ?? '';
        genderController.text = _userSnapshot['gender'] ?? '';
        _selectedImage = profileImageUrl != null
            ? XFile(profileImageUrl) // Assuming XFile supports direct URL usage
            : null;
        _isLoading = false; // Set loading state to false
      });
    } catch (error) {
      print("Error fetching user data: $error");
      // Handle error
    }
  }
bool _isLoading = true;

  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // Show bottom sheet with options
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () async {
                Navigator.of(context).pop();
                final XFile? pickedImage =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  setState(() {
                    _selectedImage = pickedImage;
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a Photo'),
              onTap: () async {
                Navigator.of(context).pop();
                final XFile? pickedImage =
                    await _picker.pickImage(source: ImageSource.camera);
                if (pickedImage != null) {
                  setState(() {
                    _selectedImage = pickedImage;
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: _isLoading
                ? Center(child: CircularProgressIndicator())
                :
            
             SizedBox(
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
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: appTheme
                                                .teal700, // Set border color here
                                            width: 4, // Set border width here
                                          ),
                                        ),
                                        child: CircleAvatar(
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
                                                .teal700, // Set border color here
                                            width: 4, // Set border width here
                                          ),
                                        ),
                                        child: GestureDetector(
                                          onTap: () => _pickImage(),
                                          child: CircleAvatar(
                                            radius: 64,
                                            backgroundImage:  NetworkImage(
                                                    _userSnapshot['profileUrl'])
                                              
                                            // Add child here if needed
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 9.h),
                                        child: CustomIconButton(
                                          height: 33.adaptSize,
                                          width: 33.adaptSize,
                                          padding: EdgeInsets.all(7.h),
                                          decoration:
                                              IconButtonStyleHelper.outlineTeal,
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            child: GestureDetector(
                                              child: CustomImageView(
                                                imagePath: ImageConstant
                                                    .imgTelevisionTeal700,
                                                onTap: () {
                                                  null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                              SizedBox(height: 30.v),
                              Container(
                                decoration: AppDecoration.outlineBlack.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder12),
                                child: CustomTextFormField(
                                  prefix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          21.h, 20.v, 8.h, 20.v),
                                      child: Icon(
                                        Icons.person,
                                        color: appTheme.blueGray900,
                                        size: 20.v,
                                      )),
                                  controller: fullnameController,
                                  hintText: "Full Name",
                                  contentPadding: EdgeInsets.only(
                                      left: 16.0,
                                      top:
                                          35), // Adjust the left padding as needed
                                ),
                              ),
                              SizedBox(height: 20.v),
                              Container(
                                decoration: AppDecoration.outlineBlack.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder12),
                                child: CustomTextFormField(
                                  prefix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          21.h, 20.v, 8.h, 20.v),
                                      child: Icon(
                                        Icons.call,
                                        color: appTheme.blueGray900,
                                        size: 20.v,
                                      )),
                                  controller: nameController,
                                  hintText: "Nick Name",
                                  contentPadding:
                                      EdgeInsets.only(left: 16.0, top: 35),
                                ),
                              ),
                              SizedBox(height: 20.v),
                              Container(
                                decoration: AppDecoration.outlineBlack.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder12),
                                child: CustomTextFormField(
                                  controller: dateOfBirthController,
                                  hintText: " DOB",
                                  contentPadding:
                                      EdgeInsets.only(left: 16.0, top: 35),
                                  prefix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          21.h, 20.v, 8.h, 20.v),
                                      child: GestureDetector(
                                        child: Icon(
                                          Icons.calendar_month,
                                          color: appTheme.blueGray900,
                                          size: 20.v,
                                        ),
                                        onTap: () => (),
                                      )),
                                ),
                              ),
                              SizedBox(height: 20.v),
                              Container(
                                decoration: AppDecoration.outlineBlack.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder12),
                                child: CustomTextFormField(
                                  prefix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          21.h, 20.v, 8.h, 20.v),
                                      child: Icon(
                                        Icons.email,
                                        color: appTheme.blueGray900,
                                        size: 20.v,
                                      )),
                                  controller: emailController,
                                  hintText: " email",
                                  contentPadding:
                                      EdgeInsets.only(left: 16.0, top: 35),
                                ),
                              ),
                              SizedBox(height: 20.v),
                              Container(
                                decoration: AppDecoration.outlineBlack.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder12),
                                child: CustomTextFormField(
                                  prefix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          21.h, 20.v, 8.h, 20.v),
                                      child: Icon(
                                        Icons.phone,
                                        color: appTheme.blueGray900,
                                        size: 20.v,
                                      )),
                                  controller: phoneNumberController,
                                  hintText: " phone",
                                  contentPadding:
                                      EdgeInsets.only(left: 16.0, top: 35),
                                ),
                              ),
                              SizedBox(height: 20.v),
                              Container(
                                decoration: AppDecoration.outlineBlack.copyWith(
                                    borderRadius:
                                        BorderRadiusStyle.roundedBorder12),
                                child: CustomTextFormField(
                                  prefix: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.person_2_rounded,
                                      color: appTheme.blueGray900,
                                      size: 20.v,
                                    ),
                                  ),
                                  controller: genderController,
                                  hintText: "Gender ",
                                  contentPadding:
                                      EdgeInsets.only(left: 16.0, top: 35),
                                ),
                              ),
                              SizedBox(height: 20.v),
                              _buildUpdateButton(),
                              SizedBox(height: 5.v)
                            ])))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: appTheme.blue50,
      leadingWidth: 61.h,
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
      onPressed: () async {
        try {
          // Step 1: Upload Image to Firebase Storage
          if (_selectedImage != null) {
            Reference storageReference = FirebaseStorage.instance
                .ref()
                .child('user_images');
            UploadTask uploadTask =
                storageReference.putFile(File(_selectedImage!.path));
            await uploadTask.whenComplete(() => null);
          }

          // Step 2: Get Download URL
          String? profileUrl;
          if (_selectedImage != null) {
            profileUrl = await FirebaseStorage.instance
                .ref('user_images')
                .getDownloadURL();
          }

          // Step 3: Update User Profile Data in Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(_user.uid)
              .update({
            'fullname': fullnameController.text,
            'nickname': nameController.text,
            'dateofbirth': dateOfBirthController.text,
            'email': emailController.text,
            'phone': phoneNumberController.text,
            'gender': genderController.text,
            'profileUrl': profileUrl,
          });

          // Update controllers with the new values
          setState(() {
            fullnameController.text = fullnameController.text;
            nameController.text = nameController.text;
            dateOfBirthController.text = dateOfBirthController.text;
            emailController.text = emailController.text;
            phoneNumberController.text = phoneNumberController.text;
            genderController.text = genderController.text;
          });

          // Optionally, you can show a success message or navigate to another screen.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully!')),
          );
        } catch (error) {
          print("Error updating user data: $error");
          // Handle error
        }
      },
    );
  }
}
