import 'package:edumike/screens/loginscreen/forgot_password_screen.dart';
import 'package:edumike/screens/loginscreen/google_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:edumike/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();
  bool _showPasswordInfo = false;

  bool rememberMe = false;
  bool _obscureText = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                                              Text("EDUWISE",
                                                  style: theme
                                                      .textTheme.headlineLarge),
                                              Text(
                                                  "Learn From Home"
                                                      .toUpperCase(),
                                                  style: theme
                                                      .textTheme.labelMedium)
                                            ]))
                                      ])),
                              SizedBox(height: 62.v),
                              Text("Let’s Sign In.!",
                                  style: theme.textTheme.headlineSmall),
                              SizedBox(height: 8.v),
                              Text(
                                  "Login to Your Account to Access your Course",
                                  style: theme.textTheme.titleSmall),
                              SizedBox(height: 48.v),
                              CustomTextFormField(
                                  controller: emailController,
                                  focusNode: emailFocusNode,
                                  hintText: "Email",
                                  textInputType: TextInputType.emailAddress,
                                  onTap: () {
                                    emailFocusNode.requestFocus();
                                  },
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
                              Stack(
                                children: [
                                  CustomTextFormField(
                                    controller: passwordController,
                                    focusNode: passwordFocusNode,
                                    hintText: "Password",
                                    textInputAction: TextInputAction.done,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    onTap: () {
                                      passwordFocusNode.requestFocus();
                                      setState(() {
                                        _showPasswordInfo = true;
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        _showPasswordInfo = value.isEmpty;
                                      });
                                    },
                                    prefix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          22.h, 20.v, 9.h, 20.v),
                                      child: CustomImageView(
                                        imagePath: ImageConstant.imgLocation,
                                        height: 19.v,
                                        width: 14.h,
                                      ),
                                    ),
                                    prefixConstraints:
                                        BoxConstraints(maxHeight: 60.v),
                                    suffix: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          30.h, 21.v, 24.h, 21.v),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                            _showPasswordInfo =
                                                false; // Ensure password info is hidden when toggling obscure text
                                          });
                                        },
                                        child: CustomImageView(
                                          imagePath: _obscureText
                                              ? ImageConstant.imgThumbsup
                                              : ImageConstant
                                                  .passwordvisible, // Change image based on _obscureText value
                                          height: 20.v,
                                          width: 20.h,
                                        ),
                                      ),
                                    ),
                                    suffixConstraints:
                                        BoxConstraints(maxHeight: 60.v),
                                    obscureText: _obscureText,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 21.v),
                                    borderDecoration: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.h),
                                      borderSide: BorderSide(
                                        color: passwordController.text.isEmpty
                                            ? appTheme.blueA700
                                            : _validatePassword()
                                                ? appTheme.blueA700
                                                : Colors.red,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -70.0, // Adjust this value as needed
                                    right: 0.0,
                                    left: 0.0,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(
                                          top: _showPasswordInfo ? 8.0 : 0.0),
                                      child: !_showPasswordInfo
                                          ? const SizedBox.shrink()
                                          : const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Password Requirements:",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(height: 4),
                                                Text("• MinLength >= 8"),
                                                Text("• Has UpperCase"),
                                                Text("• Has LowerCase"),
                                                Text("• Has Digit"),
                                                Text(
                                                    "• Has Special Characters"),
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 23.v),
                              _buildLoginOptions(context),
                              SizedBox(height: 36.v),
                              GestureDetector(
                                  onTap: () {
                                    onTapBtnsignUserIn(context);
                                  },
                                  child: _buildSignInButton(context)),
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
                                        GestureDetector(
                                          onTap: () {
                                            GoogleAuth()
                                                .signInWithGoogle(context);
                                          },
                                          child: CustomIconButton(
                                            height: 48.adaptSize,
                                            width: 48.adaptSize,
                                            padding: EdgeInsets.all(13.h),
                                            child: CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgCircle,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 50.h),
                                            child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Coming Soon!!"),
                                                      content: const Text(
                                                          "Apple SIgn-In feature will be available soon!!"),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text('Ok'),
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
                                                      imagePath: ImageConstant
                                                          .imgCirclePrimarycontainer)),
                                            ))
                                      ])),
                              SizedBox(height: 50.v),
                              Align(
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
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              "Don’t have an Account? ",
                                                          style: CustomTextStyles
                                                              .titleSmallff545454),
                                                      TextSpan(
                                                          text: "SIGN UP",
                                                          style: CustomTextStyles
                                                              .titleSmallff0961f5,
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {
                                                                  onTapTxtDonthaveanaccount(
                                                                      context);
                                                                })
                                                    ]),
                                                    textAlign: TextAlign.left)),
                                            Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: SizedBox(
                                                    width: 57.h,
                                                    child: Divider(
                                                        endIndent: 1.h)))
                                          ]))),
                              SizedBox(height: 5.v)
                            ]))))));
  }

  /// Section Widget
  Widget _buildLoginOptions(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          rememberMe = !rememberMe; // Toggle the value
        });
      },
      child: Row(
        children: [
          Align(
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
                      color: rememberMe
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
                        color: rememberMe
                            ? Colors.white
                            : Colors
                                .transparent, // Text color when checked: white
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Text(
                    "Remember me",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        onTapTxtForgotPassword(context);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(top: 2.v, left: 95),
                          child: Text(
                            "Forgot password?",
                            style: CustomTextStyles.titleSmallff0961f5,
                          )))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSignInButton(BuildContext context) {
    return Container(
      height: 60.v,
      width: 350.h,
      margin: EdgeInsets.only(left: 5.h),
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
                      borderRadius: BorderRadius.circular(30.h),
                      boxShadow: [
                        BoxShadow(
                            color: theme.colorScheme.primary,
                            spreadRadius: 2.h,
                            blurRadius: 2.h,
                            offset: const Offset(1, 2))
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
                          style: CustomTextStyles.titleMediumJostOnError)),
                  Padding(
                      padding: EdgeInsets.only(left: 89.h),
                      child: CustomIconButton(
                          height: 48.adaptSize,
                          width: 48.adaptSize,
                          padding: EdgeInsets.all(13.h),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgFill1)))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void onTapBtnsignUserIn(BuildContext context) async {
    // Check if email and password are not empty
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      // Show an error dialog for incomplete fields
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please fill in both email and password.'),
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
      return; // Exit the function if any field is empty
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

    // Sign in user
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
      if (FirebaseAuth.instance.currentUser != null) {
        // Move to the home screen
        Navigator.pushReplacementNamed(
            context, AppRoutes.homemainpageContainerScreen);
      }
    } on FirebaseAuthException {
      Navigator.pop(context);
      signinErrorMessage('Please check your username and password', context);
    }
  }

  void signinErrorMessage(String m, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(m),
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

  /// Navigates to the forgotPasswordScreen when the action is triggered.
  void onTapTxtForgotPassword(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ForgotPasswordScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  /// Navigates to the registerNowScreen when the action is triggered.
  onTapTxtDonthaveanaccount(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.registerNowScreen);
  }

  bool _validatePassword() {
    String password = passwordController.text;
    bool hasMinLength = password.length >= 8;
    bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowerCase = password.contains(RegExp(r'[a-z]'));
    bool hasDigit = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return hasMinLength &&
        hasUpperCase &&
        hasLowerCase &&
        hasDigit &&
        hasSpecialCharacters;
  }
}
