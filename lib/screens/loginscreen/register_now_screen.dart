import 'package:edumike/screens/loginscreen/google_auth.dart';
import 'package:edumike/screens/loginscreen/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_checkbox_button.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:edumike/widgets/custom_text_form_field.dart';
import 'package:flutter/widgets.dart';

class RegisterNowScreen extends StatelessWidget {
  RegisterNowScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool termsAgreement = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 34.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgTelevision,
                        height: 70.adaptSize,
                        width: 70.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 12.h,
                          top: 5.v,
                          bottom: 20.v,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "EDUPRO",
                              style: theme.textTheme.headlineLarge,
                            ),
                            Text(
                              "Learn From Home".toUpperCase(),
                              style: theme.textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 61.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Getting Started.!",
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                  SizedBox(height: 9.v),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Create an Account to Continue your allCourses",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  SizedBox(height: 48.v),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: "Email",
                    textInputType: TextInputType.emailAddress,
                    prefix: Container(
                      margin: EdgeInsets.fromLTRB(20.h, 22.v, 7.h, 23.v),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgLock,
                        height: 14.v,
                        width: 18.h,
                      ),
                    ),
                    prefixConstraints: BoxConstraints(
                      maxHeight: 60.v,
                    ),
                  ),
                  SizedBox(height: 20.v),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: "Password",
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    prefix: Container(
                      margin: EdgeInsets.fromLTRB(22.h, 20.v, 9.h, 20.v),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgLocation,
                        height: 19.v,
                        width: 14.h,
                      ),
                    ),
                    prefixConstraints: BoxConstraints(
                      maxHeight: 60.v,
                    ),
                    suffix: Container(
                      margin: EdgeInsets.fromLTRB(30.h, 21.v, 24.h, 21.v),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgThumbsup,
                        height: 15.adaptSize,
                        width: 15.adaptSize,
                      ),
                    ),
                    suffixConstraints: BoxConstraints(
                      maxHeight: 60.v,
                    ),
                    obscureText: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 21.v),
                  ),
                  SizedBox(height: 20.v),
                  _buildTermsAgreement(context),
                  SizedBox(height: 35.v),
                  _buildRegistrationForm(context),
                  SizedBox(height: 24.v),
                  Text(
                    "Or Continue With",
                    style: CustomTextStyles.titleSmallExtraBold_1,
                  ),
                  SizedBox(height: 25.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          GoogleAuth().signInWithGoogle(context);
                        },
                        child: CustomIconButton(
                          height: 48.adaptSize,
                          width: 48.adaptSize,
                          padding: EdgeInsets.all(13.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgCircle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50.h),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Coming Soon!!"),
                                  content: const Text(
                                      "Apple SIgn-In feature will be available soon!!"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: CustomIconButton(
                            height: 48.adaptSize,
                            width: 48.adaptSize,
                            padding: EdgeInsets.all(14.h),
                            child: CustomImageView(
                              imagePath:
                                  ImageConstant.imgCirclePrimarycontainer,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 52.v),
                  SizedBox(
                    height: 18.v,
                    width: 232.h,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Already have an Account? ",
                                  style: CustomTextStyles.titleSmallff545454,
                                ),
                                TextSpan(
                                    text: "SIGN IN",
                                    style: CustomTextStyles.titleSmallff0961f5,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        onTapSignInWithYourAccount(context);
                                      }),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 1.v),
                            child: SizedBox(
                              width: 52.h,
                              child: Divider(
                                color: appTheme.blueA700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTermsAgreement(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CustomCheckboxButton(
        alignment: Alignment.centerLeft,
        text: "Agree to Terms & Conditions",
        value: termsAgreement,
        padding: EdgeInsets.symmetric(vertical: 1.v),
        onChange: (value) {
          termsAgreement = value;
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildRegistrationForm(BuildContext context) {
    return SizedBox(
      height: 60.v,
      width: 350.h,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 60.v,
              width: 350.h,
              decoration: BoxDecoration(
                color: appTheme.blueA700,
                borderRadius: BorderRadius.circular(
                  30.h,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary,
                    spreadRadius: 2.h,
                    blurRadius: 2.h,
                    offset: Offset(
                      1,
                      2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 9.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 12.v,
                      bottom: 8.v,
                    ),
                    child: Text(
                      "Sign Up",
                      style: CustomTextStyles.titleMediumJostOnError,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 85.h),
                    child: CustomIconButton(
                      onTap: () {
                        onTapBtnSIgnup(context);
                      },
                      height: 48.adaptSize,
                      width: 48.adaptSize,
                      padding: EdgeInsets.all(13.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgFill1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onTapBtnSIgnup(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.fillYourProfileScreen);
  }

  onTapSignInWithYourAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
