import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_checkbox_button.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:edumike/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomImageView(
                                            imagePath:
                                                ImageConstant.imgTelevision,
                                            height: 70.adaptSize,
                                            width: 70.adaptSize),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 12.h,
                                                top: 5.v,
                                                bottom: 20.v),
                                            child: Column(children: [
                                              Text("EDUPRO",
                                                  style: theme.textTheme
                                                      .headlineLarge),
                                              Text(
                                                  "Learn From Home"
                                                      .toUpperCase(),
                                                  style: theme.textTheme
                                                      .labelMedium)
                                            ]))
                                      ])),
                              SizedBox(height: 62.v),
                              Text("Let’s Sign In.!",
                                  style: theme.textTheme.headlineSmall),
                              SizedBox(height: 8.v),
                              Text(
                                  "Login to Your Account to Continue your Courses",
                                  style: theme.textTheme.titleSmall),
                              SizedBox(height: 48.v),
                              CustomTextFormField(
                                  controller: emailController,
                                  hintText: "Email",
                                  textInputType: TextInputType.emailAddress,
                                  prefix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          20.h, 22.v, 7.h, 23.v),
                                      child: CustomImageView(
                                          imagePath: ImageConstant.imgLock,
                                          height: 14.v,
                                          width: 18.h)),
                                  prefixConstraints:
                                      BoxConstraints(maxHeight: 60.v)),
                              SizedBox(height: 20.v),
                              CustomTextFormField(
                                  controller: passwordController,
                                  hintText: "Password",
                                  textInputAction: TextInputAction.done,
                                  textInputType:
                                      TextInputType.visiblePassword,
                                  prefix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          22.h, 20.v, 9.h, 20.v),
                                      child: CustomImageView(
                                          imagePath:
                                              ImageConstant.imgLocation,
                                          height: 19.v,
                                          width: 14.h)),
                                  prefixConstraints:
                                      BoxConstraints(maxHeight: 60.v),
                                  suffix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          30.h, 21.v, 24.h, 21.v),
                                      child: CustomImageView(
                                          imagePath:
                                              ImageConstant.imgThumbsup,
                                          height: 15.adaptSize,
                                          width: 15.adaptSize)),
                                  suffixConstraints:
                                      BoxConstraints(maxHeight: 60.v),
                                  obscureText: true,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 21.v)),
                              SizedBox(height: 23.v),
                              _buildLoginOptions(context),
                              SizedBox(height: 36.v),
                              _buildSignInButton(context),
                              SizedBox(height: 24.v),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text("Or Continue With",
                                      style: CustomTextStyles
                                          .titleSmallExtraBold_1)),
                              SizedBox(height: 25.v),
                              Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomIconButton(
                                            height: 48.adaptSize,
                                            width: 48.adaptSize,
                                            padding: EdgeInsets.all(13.h),
                                            child: CustomImageView(
                                                imagePath: ImageConstant
                                                    .imgCircle)),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 50.h),
                                            child: CustomIconButton(
                                                height: 48.adaptSize,
                                                width: 48.adaptSize,
                                                padding:
                                                    EdgeInsets.all(14.h),
                                                child: CustomImageView(
                                                    imagePath: ImageConstant
                                                        .imgCirclePrimarycontainer)))
                                      ])),
                              SizedBox(height: 50.v),
                              GestureDetector(
                                onTap: () {
                                  onTapTxtDonthaveanaccount(context);
                                }  ,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                        height: 18.v,
                                        width: 221.h,
                                        child: Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: RichText(
                                                      text:
                                                          TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                "Don’t have an Account? ",
                                                            style: CustomTextStyles
                                                                .titleSmallff545454),
                                                        TextSpan(
                                                            text: "SIGN UP",
                                                            style: CustomTextStyles
                                                                .titleSmallff0961f5)
                                                      ]),
                                                      textAlign:
                                                          TextAlign.left)),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: SizedBox(
                                                      width: 57.h,
                                                      child: Divider(
                                                          endIndent: 1.h)))
                                            ]))),
                              ),
                              SizedBox(height: 5.v)
                            ]))))));
  }

  /// Section Widget
  Widget _buildLoginOptions(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(bottom: 1.v),
          child: CustomCheckboxButton(
              text: "Remember Me",
              value: rememberMe,
              padding: EdgeInsets.symmetric(vertical: 1.v),
              onChange: (value) {
                rememberMe = value;
              })),
      GestureDetector(
          onTap: () {
            onTapTxtForgotPassword(context);
          },
          child: Padding(
              padding: EdgeInsets.only(top: 2.v),
              child:
                  Text("Forgot Password?", style: theme.textTheme.labelLarge)))
    ]);
  }

  /// Section Widget
  Widget _buildSignInButton(BuildContext context) {
    return Container(
        height: 60.v,
        width: 350.h,
        margin: EdgeInsets.only(left: 5.h),
        child: Stack(alignment: Alignment.centerRight, children: [
          Align(
              alignment: Alignment.center,
              child: Container(
                  height: 60.v,
                  width: 350.h,
                  decoration: BoxDecoration(
                      color: appTheme.blueA700,
                      borderRadius: BorderRadius.circular(30.h),
                      boxShadow: [
                        BoxShadow(
                            color: theme.colorScheme.primary,
                            spreadRadius: 2.h,
                            blurRadius: 2.h,
                            offset: Offset(1, 2))
                      ]))),
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                  padding: EdgeInsets.only(right: 9.h),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 12.v, bottom: 8.v),
                            child: Text("Sign In",
                                style:
                                    CustomTextStyles.titleMediumJostOnError)),
                        Padding(
                            padding: EdgeInsets.only(left: 89.h),
                            child: CustomIconButton(
                                height: 48.adaptSize,
                                width: 48.adaptSize,
                                padding: EdgeInsets.all(13.h),
                                child: CustomImageView(
                                    imagePath: ImageConstant.imgFill1)))
                      ])))
        ]));
  }

  /// Navigates to the forgotPasswordScreen when the action is triggered.
  onTapTxtForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.forgotPasswordScreen);
  }
  
  /// Navigates to the registerNowScreen when the action is triggered.
  onTapTxtDonthaveanaccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerNowScreen);
  }
}
