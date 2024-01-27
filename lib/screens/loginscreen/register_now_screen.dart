import 'package:edumike/screens/loginscreen/google_auth.dart';
import 'package:edumike/screens/loginscreen/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:edumike/widgets/custom_text_form_field.dart';
import 'package:flutter/widgets.dart';
import 'package:email_otp/email_otp.dart';

class RegisterNowScreen extends StatefulWidget {
  RegisterNowScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<RegisterNowScreen> createState() => _RegisterNowScreenState();
}

class _RegisterNowScreenState extends State<RegisterNowScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();

  FocusNode confirmPasswordFocusNode = FocusNode();

  bool termsAgreement = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EmailOTP myauth = EmailOTP();

          var _isObscured;

  @override
  void initState(){
    super.initState();
    _isObscured = false;
  }

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
                              "EDUWISE",
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
                    focusNode: emailFocusNode,
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
                    focusNode: passwordFocusNode,
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
                    obscureText: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 21.v),
                  ),
                  SizedBox(height: 20.v),
                  CustomTextFormField(
                    focusNode: confirmPasswordFocusNode,
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
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
                    contentPadding: EdgeInsets.symmetric(vertical: 21.v),
                  ),
                  SizedBox(height: 20.v),
                  _buildTermsAgreement(context),
                  SizedBox(height: 35.v),
                  GestureDetector(
                      onTap: () {
                        onTapBtnSIgnup(context);
                      },
                      child: _buildRegistrationForm(context)),
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

  Widget _buildTermsAgreement(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          termsAgreement = !termsAgreement; // Toggle the value
        });
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.v),
          child: Row(
            children: [
              Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle, // Set the shape to rectangle
                  color: termsAgreement
                      ? Colors.blue
                      : Colors.black, // Initial color: black
                  border: Border.all(
                    color: Colors.black, // Border color: black
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.check,
                    size: 12.0, // Adjusted size for a small checkbox
                    color: termsAgreement
                        ? Colors.white
                        : Colors.transparent, // Text color when checked: white
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              const Text(
                "Agree to Terms & Conditions",
                style: TextStyle(
                  color: Colors.black, // Change the text color as needed
                ),
              ),
            ],
          ),
        ),
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
                    offset: const Offset(
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

  // onTapBtnSIgnup(BuildContext context) {
  //   Navigator.pushNamed(context, AppRoutes.fillYourProfileScreen);
  // }
  void onTapBtnSIgnup(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        // Show an error dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Password and Confirm Password do not match'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return; // Exit the function if passwords don't match
      }
      // Show a loading indicator
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        // Create the user account
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        myauth.setConfig(
            appEmail: "flutteremperor@gmail.com",
            appName: "Email OTP",
            userEmail: emailController.text,
            otpLength: 4,
            otpType: OTPType.digitsOnly);
        if (await myauth.sendOTP() == true) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("OTP has been sent"),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Oops, OTP send failed"),
          ));
        }

        // Close the loading indicator
        Navigator.pop(context);

        // Navigate to the home screen or any other screen you desire
        Navigator.pushReplacementNamed(context, AppRoutes.verifyMailScreen);
      } on FirebaseAuthException catch (e) {
        // Close the loading indicator
        Navigator.pop(context);

        // Show an error dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(e.message ?? 'An error occurred'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  onTapSignInWithYourAccount(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
  }
}
