import 'package:edumike/screens/loginscreen/google_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_elevated_button.dart';
import 'package:edumike/widgets/custom_icon_button.dart';

class LetSYouInScreen extends StatelessWidget {
  const LetSYouInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.gray50,
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 39.h, vertical: 90.v),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text("Let’s you in",
                          style: theme.textTheme.headlineSmall),
                      SizedBox(height: 27.v),
                      GestureDetector(
                        onTap: () {
                          GoogleAuth().signInWithGoogle(context);
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomIconButton(
                                  height: 48.adaptSize,
                                  width: 48.adaptSize,
                                  padding: EdgeInsets.all(13.h),
                                  child: CustomImageView(
                                      imagePath: ImageConstant.imgGoogle)),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 12.h, top: 15.v, bottom: 11.v),
                                  child: Text("Continue with Google",
                                      style:
                                          CustomTextStyles.titleMediumGray700))
                            ]),
                      ),
                      SizedBox(height: 24.v),
                      GestureDetector(
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomIconButton(
                                  height: 48.adaptSize,
                                  width: 48.adaptSize,
                                  padding: EdgeInsets.all(14.h),
                                  child: CustomImageView(
                                      imagePath: ImageConstant.imgGroup3)),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 12.h, top: 15.v, bottom: 11.v),
                                  child: Text("Continue with Apple",
                                      style:
                                          CustomTextStyles.titleMediumGray700))
                            ]),
                      ),
                      SizedBox(height: 60.v),
                      Text("( Or )",
                          style: CustomTextStyles.titleSmallExtraBold),
                      SizedBox(height: 28.v),
                      CustomElevatedButton(
                          text: "Sign In with Your Account",
                          onPressed: () {
                            onTapSignInWithYourAccount(context);
                          }),
                      SizedBox(height: 29.v),
                      RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Don’t have an Account? ",
                                style: CustomTextStyles.titleSmallff545454),
                            TextSpan(
                                text: "SIGN UP",
                                style: CustomTextStyles.titleSmallff0961f5,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    onTapTxtDonthaveanaccount(context);
                                  }),
                          ]),
                          textAlign: TextAlign.left),
                      Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                              width: 121.h, child: Divider(endIndent: 65.h)))
                    ]))));
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapSignInWithYourAccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }

  /// Navigates to the registerNowScreen when the action is triggered.
  onTapTxtDonthaveanaccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerNowScreen);
  }
}
