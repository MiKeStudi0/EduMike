import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:edumike/screens/Homescreen/homemainpage_container_screen/homemainpage_container_screen.dart';
import 'package:edumike/screens/Homescreen/homemainpage_page/homemainpage_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

Future<DocumentSnapshot<Map<String, dynamic>>> getUserDocument() async {
  // Get the current user
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    throw Exception('User not authenticated');
  }

  // Retrieve the user document from Firestore
  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

  return snapshot;
}

// ignore_for_file: must_be_immutable
class FillYourProfileScreen extends StatefulWidget {
  FillYourProfileScreen({Key? key}) : super(key: key);

  @override
  State<FillYourProfileScreen> createState() => _FillYourProfileScreenState();
}

class _FillYourProfileScreenState extends State<FillYourProfileScreen> {
  TextEditingController fullNameEditTextController = TextEditingController();
  late final String gendervalue;
  // DateTime _picked=DateTime.now();

  Future<void> _selectdate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2500));
    if (_picked != null) {
      setState(() {
        dateOfBirthEditTextController.text =
            DateFormat('yyyy-MM-dd').format(_picked);
      });
    }
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
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 34.h, vertical: 29.v),
                            child: Column(children: [
                              SizedBox(
                                  height: 100.adaptSize,
                                  width: 100.adaptSize,
                                  child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                                height: 100.adaptSize,
                                                width: 100.adaptSize,
                                                decoration: BoxDecoration(
                                                    color: appTheme.blue50,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.h)))),
                                        CustomImageView(
                                            imagePath:
                                                ImageConstant.imgFill1Gray50,
                                            height: 76.v,
                                            width: 70.h,
                                            alignment: Alignment.bottomCenter),
                                        CustomIconButton(
                                            height: 30.adaptSize,
                                            width: 30.adaptSize,
                                            padding: EdgeInsets.all(7.h),
                                            alignment: Alignment.bottomRight,
                                            child: CustomImageView(
                                                imagePath:
                                                    ImageConstant.imgGroup20))
                                      ])),
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
  Widget _buildEmailEditText(BuildContext context) {
    return CustomTextFormField(
        focusNode: emailFocusNode,
        controller: emailEditTextController,
        hintText: "Email(Verify)",
        hintStyle: theme.textTheme.bodyMedium!,
        textInputType: TextInputType.emailAddress,
        prefix: Container(
            margin: EdgeInsets.fromLTRB(20.h, 23.v, 7.h, 22.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgLock, height: 14.v, width: 18.h)),
        prefixConstraints: BoxConstraints(maxHeight: 60.v));
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
                      print('User data added to Firestore successfully!');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomemainpageContainerScreen()), // Replace HomePage with your actual homepage widget
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
                                    child: CustomImageView()),
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

    // Replace the field names and values as per your data structure
    await userCollection.doc(userId).set({
      'fullname': fullNameEditTextController.text,
      'nickname': nameEditTextController.text,
      'dateofbirth': dateOfBirthEditTextController.text,
      'email': emailEditTextController.text,
      'phone': phoneNumberController.text,
      'gender': gendervalue,
    });
  }
}
