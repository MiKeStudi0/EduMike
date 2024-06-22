import 'dart:io';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:edumike/screens/Homescreen/homemainpage_container_screen/homemainpage_container_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image.dart';
import 'package:edumike/widgets/app_bar/appbar_title.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_drop_down.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:edumike/widgets/custom_phone_number.dart';
import 'package:edumike/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocument() async {
  // Get the current user
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    throw Exception('User not authenticated or found');
  }

  // Retrieve the user document from Firestore
  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  return snapshot;
}

// ignore_for_file: must_be_immutable
class FillYourProfileScreen extends StatefulWidget {
  const FillYourProfileScreen({super.key});

  @override
  State<FillYourProfileScreen> createState() => _FillYourProfileScreenState();
}

class _FillYourProfileScreenState extends State<FillYourProfileScreen> {
  String userEmail = '';
  TextEditingController fullNameEditTextController = TextEditingController();
  late final String gendervalue;
  // DateTime _picked=DateTime.now();

  Future<void> _selectdate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2500));
    if (picked != null) {
      setState(() {
        dateOfBirthEditTextController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

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
                  _pickImageCallback(pickedImage.path);
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
                  _pickImageCallback(pickedImage.path);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _pickImageCallback(String imagePath) {
    setState(() {
      _selectedImage = XFile(imagePath);
    });
  }

  FocusNode emailFocusNode = FocusNode();

  FocusNode dateofbirthFocusNode = FocusNode();

  FocusNode fullnameFocusNode = FocusNode();

  FocusNode nicknameFocusNode = FocusNode();

  TextEditingController nameEditTextController = TextEditingController();

  TextEditingController dateOfBirthEditTextController = TextEditingController();

  TextEditingController emailEditTextController = TextEditingController();

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('91');

  TextEditingController phoneNumberController = TextEditingController();

  List<String> dropdownItemList = ["Male", "Female"];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Retrieve the currently signed-in user's email
    getUserEmail();
  }

  Future<void> getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email ?? 'No email found';
      });
    }
  }

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
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 34.h, vertical: 29.v),
                            child: Column(children: [
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
                                        child: GestureDetector(
                                          onTap: () => (_pickImage()),
                                          child: CircleAvatar(
                                            radius: 64,
                                            backgroundImage: _selectedImage !=
                                                    null
                                                ? FileImage(
                                                    File(_selectedImage!.path))
                                                : null,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(right: 3.h),
                                          child: CustomIconButton(
                                              height: 29.adaptSize,
                                              width: 29.adaptSize,
                                              padding: EdgeInsets.all(6.h),
                                              decoration: IconButtonStyleHelper
                                                  .outlineTeal,
                                              alignment: Alignment.bottomRight,
                                              child: Icon(Icons.edit,
                                                  size: 15.adaptSize,
                                                  color: appTheme
                                                      .blue600))) // Add child here if needed
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.v),
                              _buildFullNameEditText(context),
                              SizedBox(height: 20.v),
                              _buildNameEditText(context),
                              SizedBox(height: 20.v),
                              _buildDateOfBirthEditText(context),
                              SizedBox(height: 20.v),
                              _buildEmailEditText(
                                  context, emailEditTextController, userEmail),
                              SizedBox(height: 20.v),
                              _buildPhoneNumber(context),
                              SizedBox(height: 20.v),
                              CustomDropDown(
                                  hintText: "Gender",
                                  items: dropdownItemList,
                                  onChanged: (value) {
                                    setState(() {
                                      gendervalue = value;
                                      print(gendervalue);
                                    });
                                  }),
                              SizedBox(height: 50.v),
                              _buildContinueButton(context),
                              SizedBox(height: 5.v)
                            ])))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 61.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowDown,
            margin: EdgeInsets.only(left: 35.h, top: 18.v, bottom: 17.v)),
        title: AppbarTitle(
            text: "Fill Your Profile", margin: EdgeInsets.only(left: 12.h)));
  }

  /// Section Widget
  Widget _buildFullNameEditText(BuildContext context) {
    return CustomTextFormField(
        focusNode: fullnameFocusNode,
        controller: fullNameEditTextController,
        hintText: "Full Name",
        contentPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 21.v));
  }

  /// Section Widget
  Widget _buildNameEditText(BuildContext context) {
    return CustomTextFormField(
        focusNode: nicknameFocusNode,
        controller: nameEditTextController,
        hintText: "Nick Name",
        contentPadding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 21.v));
  }

  /// Section Widget
  Widget _buildDateOfBirthEditText(BuildContext context) {
    return CustomTextFormField(
        focusNode: dateofbirthFocusNode,
        controller: dateOfBirthEditTextController,
        hintText: "Date of Birth",
        prefix: Container(
            margin: EdgeInsets.fromLTRB(21.h, 20.v, 8.h, 20.v),
            child: GestureDetector(
              child: CustomImageView(
                  onTap: () {
                    _selectdate();
                  },
                  imagePath: ImageConstant.imgCalendar,
                  height: 20.v,
                  width: 18.h),
            )),
        prefixConstraints: BoxConstraints(maxHeight: 60.v));
  }

  /// Section Widget
  Widget _buildEmailEditText(BuildContext context,
      TextEditingController emailTextController, String userEmail) {
    // Set initial text to the controller
    emailTextController.text = userEmail;

    return Container(
      margin: EdgeInsets.fromLTRB(0, 10.v, 0, 10.v),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0XFF0961F5)), // Blue border
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: 18, right: 7.h),
              child: CustomImageView(
                  imagePath: ImageConstant.imgLock, height: 14.v, width: 18.h)),
          Expanded(
            child: TextFormField(
              enabled: false,
              focusNode: FocusNode(), // Disabling focus
              controller: emailTextController,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.black),
              // decoration: InputDecoration(
              //   // hintText: "Email(Verify)",
              //   // hintStyle: theme.textTheme.bodyMedium!,
              //   border: InputBorder.none, // No need for border here
              // ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return CustomPhoneNumber(
        country: selectedCountry,
        controller: phoneNumberController,
        onTap: (Country value) {
          selectedCountry = value;
        });
  }

  /// Section Widget
  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
        height: 60.v,
        width: 350.h,
        child: Stack(alignment: Alignment.center, children: [
          Align(
              alignment: Alignment.center,
              child: GestureDetector(
                  onTap: () async {
                    try {
                      await addUserToFirestore();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const HomemainpageContainerScreen()), // Replace HomePage with your actual homepage widget
                      );
                    } catch (e) {
                      print('Error adding user data to Firestore: $e');
                    }
                  },
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      margin: const EdgeInsets.all(0),
                      color: appTheme.blueA700,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusStyle.circleBorder30),
                      child: Container(
                          height: 60.v,
                          width: 350.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 9.h, vertical: 6.v),
                          decoration: AppDecoration.outlinePrimary.copyWith(
                              borderRadius: BorderRadiusStyle.circleBorder30),
                          child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                CustomIconButton(
                                    height: 48.adaptSize,
                                    width: 48.adaptSize,
                                    alignment: Alignment.centerRight,
                                    child: const CustomImageView()),
                                CustomImageView(
                                    imagePath: ImageConstant.imgFill1,
                                    height: 17.v,
                                    width: 21.h,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(right: 13.h))
                              ]))))),
          Align(
              alignment: Alignment.center,
              child: Text("Continue",
                  style: CustomTextStyles.titleMediumJostOnError))
        ]));
  }

  /// Navigates to the congratulationsScreen when the action is triggered.
  Future<void> addUserToFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('User not authenticated');
    }

    // Use the user ID as the document ID
    String userId = user.uid;

    // Replace 'users' with your Firestore collection name
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');

    // Upload image to Firebase Storage
    String imagePath =
        ''; // Update with the path where you want to store images
    if (_selectedImage != null) {
      imagePath = await _uploadImageToStorage(_selectedImage!);
    }

    // Update Firestore document with image URL
    await userCollection.doc(userId).set({
      'fullname': fullNameEditTextController.text,
      'nickname': nameEditTextController.text,
      'dateofbirth': dateOfBirthEditTextController.text,
      'email': emailEditTextController.text,
      'phone': phoneNumberController.text,
      'gender': gendervalue,
      'profileUrl': imagePath, // Save the image URL in the 'profileUrl' field
    });
  }

  Future<String> _uploadImageToStorage(XFile image) async {
    // Use the Firebase Storage instance
    User? user = FirebaseAuth.instance.currentUser;
    final storage = FirebaseStorage.instance;
    final Reference storageReference =
        storage.ref().child('user_images').child(user!.uid);

    // Generate a unique filename
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Upload the image
    final UploadTask uploadTask =
        storageReference.child(fileName).putFile(File(image.path));

    // Get the download URL once the upload is complete
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    return imageUrl;
  }
}
