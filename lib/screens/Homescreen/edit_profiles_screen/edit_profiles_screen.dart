import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_drop_down.dart';
import 'package:edumike/widgets/custom_elevated_button.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:edumike/widgets/custom_phone_number.dart';
import 'package:edumike/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EditProfilesScreen extends StatelessWidget {
  EditProfilesScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController fullNameController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('91');

  TextEditingController phoneNumberController = TextEditingController();

  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

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
                  CustomDropDown(
                    hintText: "Gender",
                    items: dropdownItemList,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 22.h,
                      vertical: 21.v,
                    ),
                   // borderDecoration: DropDownStyleHelper.outlineBlackTL12,
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 18.v),
                  _buildColumn(context),
                  SizedBox(height: 40.v),
                  _buildButton(context),
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
  Widget _buildFullName(BuildContext context) {
    return CustomTextFormField(
      controller: fullNameController,
      hintText: "Full Name",
    );
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return CustomTextFormField(
      controller: nameController,
      hintText: "Nick Name",
    );
  }

  /// Section Widget
  Widget _buildDateOfBirth(BuildContext context) {
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
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
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
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return CustomPhoneNumber(
      country: selectedCountry,
      controller: phoneNumberController,
      onTap: (Country value) {
        selectedCountry = value;
      },
    );
  }

  /// Section Widget
  Widget _buildColumn(BuildContext context) {
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
  }

  /// Section Widget
  Widget _buildButton(BuildContext context) {
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
}
