import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/widgets/custom_drop_down.dart';
import 'package:edumike/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_title.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:edumike/widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// ignore_for_file: must_be_immutable
class EditProfilesScreen extends StatefulWidget {
  const EditProfilesScreen({super.key});

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

  FocusNode phoneNumberFocusNode = FocusNode();

  TextEditingController fullnameController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController genderController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  List<String> dropdownItemList = ["Male", "Female"];

  FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  late DocumentSnapshot _userSnapshot;

  final _formKey = GlobalKey<FormState>();

  Future<void> _selectdate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2500));
    if (picked != null) {
      setState(() {
        dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

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
      //  String? profileImageUrl = _userSnapshot['profileUrl'];

      // Update the state with the existing image URL
      setState(() {
        fullnameController.text = _userSnapshot['fullname'] ?? '';
        nameController.text = _userSnapshot['nickname'] ?? '';
        dateOfBirthController.text = _userSnapshot['dateofbirth'] ?? '';
        emailController.text = _userSnapshot['email'] ?? '';
        phoneNumberController.text = _userSnapshot['phone'] ?? '';
        genderController.text = _userSnapshot['gender'] ?? '';
        // _selectedImage = profileImageUrl != null
        //     ? XFile(profileImageUrl) // Assuming XFile supports direct URL usage
        //     : null;
        _isLoading = false; // Set loading state to false
      });
    } catch (error) {
      print("Error fetching user data: $error");
      // Handle error
    }
  }

  ImageProvider<Object>? _getImageProvider() {
    if (_selectedImage != null) {
      return FileImage(File(_selectedImage!.path));
    }
    return null;
  }

  ImageProvider<Object>? _getImageProviderFirebase() {
    if (_userSnapshot['profileUrl'] != null) {
      return NetworkImage(_userSnapshot['profileUrl']);
    } else {
      return const AssetImage('assets/images/EduWise.jpg');
    }
  }

  bool _isLoading = true;

  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    // Show bottom sheet with options
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Navigator.of(context).pop();
                final XFile? pickedImage =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  setState(() {
                    _selectedImage = pickedImage;
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a Photo'),
              onTap: () async {
                Navigator.of(context).pop();
                final XFile? pickedImage =
                    await picker.pickImage(source: ImageSource.camera);
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
            backgroundColor: appTheme.blue50,
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
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
                                                color: Colors.blue, // Set border color here
                                                width:
                                                    4, // Set border width here
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
                                                  color: Colors.blue,
                                                  width: 4,
                                                ),
                                              ),
                                              child: GestureDetector(
                                                onTap: () => _pickImage(),
                                                child: Container(
                                                  child: _selectedImage != null
                                                      ? CircleAvatar(
                                                          radius: 64,
                                                          backgroundImage:
                                                              _getImageProvider(),
                                                        )
                                                      : CircleAvatar(
                                                          radius: 64,
                                                          backgroundImage:
                                                              _getImageProviderFirebase(),
                                                        ),
                                                ),
                                              )),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 9.h),
                                            child: CustomIconButton(
                                              height: 33.adaptSize,
                                              width: 33.adaptSize,
                                              padding: EdgeInsets.all(7.h),
                                              decoration: IconButtonStyleHelper
                                                  .outlineTeal,
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                child: GestureDetector(
                                                  child: CustomImageView(
                                                    imagePath: ImageConstant
                                                        .profileedit,
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
                                    decoration: AppDecoration.outlineBlack
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder12),
                                    child: CustomTextFormField(
                                      prefix: Padding(
                                        padding: const EdgeInsets.all(11.0),
                                        child: CustomImageView(
                                          imagePath: ImageConstant.userIcon,
                                          height: 5.v,
                                          width: 5.h,
                                        ),
                                      ),
                                      controller: fullnameController,
                                      focusNode: fullnameFocusNode,
                                      hintText: "Full Name",
                                      contentPadding: const EdgeInsets.only(
                                          left: 16.0,
                                          top:
                                              35), // Adjust the left padding as needed
                                    ),
                                  ),
                                  SizedBox(height: 20.v),
                                  Container(
                                    decoration: AppDecoration.outlineBlack
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder12),
                                    child: CustomTextFormField(
                                      prefix: Padding(
                                        padding: const EdgeInsets.all(11.0),
                                        child: CustomImageView(
                                          imagePath: ImageConstant.nickname,
                                          height: 5.v,
                                          width: 5.h,
                                        ),
                                      ),
                                      controller: nameController,
                                      focusNode: nicknameFocusNode,
                                      hintText: "Nick Name",
                                      contentPadding: const EdgeInsets.only(
                                          left: 16.0, top: 35),
                                    ),
                                  ),
                                  SizedBox(height: 20.v),
                                  Container(
                                    decoration: AppDecoration.outlineBlack
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder12),
                                    child: CustomTextFormField(
                                      controller: dateOfBirthController,
                                      focusNode: dateofbirthFocusNode,
                                      hintText: " DOB",
                                      contentPadding: const EdgeInsets.only(
                                          left: 16.0, top: 35),
                                      prefix: Padding(
                                        padding: const EdgeInsets.all(11.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            _selectdate();
                                          },
                                          child: CustomImageView(
                                            imagePath: ImageConstant.calender,
                                            height: 5.v,
                                            width: 5.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 13.v),
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(0, 10.v, 0, 10.v),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color(
                                              0XFF0961F5)), // Blue border
                                      borderRadius: BorderRadius.circular(
                                          9.0), // Rounded corners
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: CustomImageView(
                                            imagePath: ImageConstant.google,
                                            height: 26.v,
                                            width: 26.h,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            enabled: false,
                                            focusNode:
                                                FocusNode(), // Disabling focus
                                            controller: emailController,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 13.v),
                                  Container(
                                    decoration: AppDecoration.outlineBlack
                                        .copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .roundedBorder12),
                                    child: CustomTextFormField(
                                      prefix: Padding(
                                        padding: const EdgeInsets.all(11.0),
                                        child: CustomImageView(
                                          imagePath: ImageConstant.call,
                                        ),
                                      ),
                                      controller: phoneNumberController,
                                      focusNode: phoneNumberFocusNode,
                                      hintText: " phone",
                                      contentPadding: const EdgeInsets.only(
                                          left: 16.0, top: 35),
                                    ),
                                  ),
                                  SizedBox(height: 20.v),
                                  // Container(
                                  //   decoration: AppDecoration.outlineBlack
                                  //       .copyWith(
                                  //           borderRadius: BorderRadiusStyle
                                  //               .roundedBorder12),
                                  //   child: CustomTextFormField(
                                  //     prefix: Padding(
                                  //       padding:
                                  //           const EdgeInsets.only(left: 10),
                                  //       child: Icon(
                                  //         Icons.person_2_rounded,
                                  //         color: appTheme.blueGray900,
                                  //         size: 20.v,
                                  //       ),
                                  //     ),
                                  //     controller: genderController,
                                  //     hintText: "Gender ",
                                  //     contentPadding:
                                  //         const EdgeInsets.only(left: 16.0, top: 35),
                                  //   ),
                                  // ),

                                  CustomDropDown(
                                    controller: genderController,
                                    hintText: 'gender',
                                    items: dropdownItemList,
                                    onChanged: (value) {
                                      setState(() {
                                        gendervalue = value;
                                        genderController.text = value;
                                      });
                                    },
                                    prefix: genderController.text == 'Female'
                                        ? const Icon(Icons.female,
                                            size: 32,
                                            color: Color.fromARGB(
                                                255, 14, 112, 248))
                                        : Padding(
                                            padding: const EdgeInsets.all(11.0),
                                            child: CustomImageView(
                                              imagePath: ImageConstant.gender,
                                              height: 5.v,
                                              width: 5.h,
                                            ),
                                          ),
                                  ),

                                  SizedBox(height: 20.v),
                                  _buildUpdateButton(context),
                                  SizedBox(height: 5.v)
                                ])))))));
  }

  Widget _buildUpdateButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomElevatedButton(
          width: 140.h,
          text: "Cancel",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CustomElevatedButton(
          width: 206.h,
          text: "Yes, Update",
          onPressed: () async {
            try {
              // Step 1: Upload Image to Firebase Storage
              User? user = FirebaseAuth.instance.currentUser;
              if (_selectedImage != null) {
                Reference storageReference = FirebaseStorage.instance
                    .ref()
                    .child('user_images')
                    .child(user!.uid);
                UploadTask uploadTask =
                    storageReference.putFile(File(_selectedImage!.path));
                await uploadTask.whenComplete(() => null);
              }

              // Step 2: Get Download URL
              String? profileUrl;
              if (_selectedImage != null) {
                profileUrl = await FirebaseStorage.instance
                    .ref()
                    .child('user_images')
                    .child(user!.uid)
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
                const SnackBar(content: Text('Profile updated successfully!')),
              );

              Navigator.pop(context);
            } catch (error) {
              print("Error updating user data: $error");
              // Handle error
            }
          },
        ),
      ],
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: appTheme.blue50,
      leadingWidth: 61.h,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        iconSize: 30,
        onPressed: () {
          Navigator.of(context)
              .pop(); // Navigate back when back arrow is pressed
        },
      ),
      title: AppbarTitle(
        text: "Edit Your Profile",
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }

  // Widget _buildUpdateButton() {
  //   return CustomElevatedButton(
  //     text: "Update",
  //     margin: EdgeInsets.symmetric(horizontal: 5.h),
  //     rightIcon: Container(
  //       padding: EdgeInsets.fromLTRB(14.h, 16.v, 12.h, 14.v),
  //       margin: EdgeInsets.only(left: 30.h),
  //       decoration: BoxDecoration(
  //         color: appTheme.whiteA700,
  //         borderRadius: BorderRadius.circular(24.h),
  //       ),
  //       child: CustomImageView(
  //         imagePath: ImageConstant.imgArrowrightPrimary17x21,
  //         height: 17.v,
  //         width: 21.h,
  //       ),
  //     ),
  //     onPressed: () async {
  //       try {
  //         // Step 1: Upload Image to Firebase Storage
  //         User? user = FirebaseAuth.instance.currentUser;
  //         if (_selectedImage != null) {
  //           Reference storageReference = FirebaseStorage.instance
  //               .ref()
  //               .child('user_images')
  //               .child(user!.uid);
  //           UploadTask uploadTask =
  //               storageReference.putFile(File(_selectedImage!.path));
  //           await uploadTask.whenComplete(() => null);
  //         }

  //         // Step 2: Get Download URL
  //         String? profileUrl;
  //         if (_selectedImage != null) {
  //           profileUrl = await FirebaseStorage.instance
  //               .ref()
  //               .child('user_images')
  //               .child(user!.uid)
  //               .getDownloadURL();
  //         }

  //         // Step 3: Update User Profile Data in Firestore
  //         await FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(_user.uid)
  //             .update({
  //           'fullname': fullnameController.text,
  //           'nickname': nameController.text,
  //           'dateofbirth': dateOfBirthController.text,
  //           'email': emailController.text,
  //           'phone': phoneNumberController.text,
  //           'gender': genderController.text,
  //           'profileUrl': profileUrl,
  //         });

  //         // Update controllers with the new values
  //         setState(() {
  //           fullnameController.text = fullnameController.text;
  //           nameController.text = nameController.text;
  //           dateOfBirthController.text = dateOfBirthController.text;
  //           emailController.text = emailController.text;
  //           phoneNumberController.text = phoneNumberController.text;
  //           genderController.text = genderController.text;
  //         });

  //         // Optionally, you can show a success message or navigate to another screen.
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Profile updated successfully!')),
  //         );

  //         Navigator.pop(context);
  //       } catch (error) {
  //         print("Error updating user data: $error");
  //         // Handle error
  //       }
  //     },
  //   );
  // }
}
