import 'package:edumike/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image.dart';
import 'package:edumike/widgets/app_bar/appbar_title.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(31, 231, 231, 231),
          elevation: 0,
          title: Text('Forgot Password'),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 34.h,
            vertical: 123.v,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              Container(
                width: 303.h,
                margin: EdgeInsets.symmetric(horizontal: 28.h),
                child: Text(
                  "Enter your registered Email Id to sent you a mail to Reset Your Password",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall,
                ),
              ),
              SizedBox(height: 38.v),
              _buildEmailField(),
              SizedBox(height: 40.v),
              _buildResetButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, // Border color
          width: 1.0, // Border width
        ),
        borderRadius: BorderRadius.circular(10.0), // Border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset: Offset(0, 1), // Offset of the shadow
          ),
        ],
      ),
      child: CustomTextFormField(
        controller: emailController,
        focusNode: emailFocusNode,
        hintText: "Registered Email",
        textInputType: TextInputType.emailAddress,
        onTap: () {
          emailFocusNode.requestFocus();
        },
        prefix: Container(
          margin: EdgeInsets.fromLTRB(20.h, 22.v, 7.h, 23.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgLock,
            height: 14.v,
            width: 18.h,
          ),
        ),
        prefixConstraints: BoxConstraints(maxHeight: 60.v),
      ),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return Container(
      width: 225.h, // Make the button take the full width
      height: 60.0, // Set the desired height of the button
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0), // Apply border radius
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset: Offset(0, 3), // Offset of the shadow
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: () {
          _resetPassword(context);
        },
        color: appTheme.blueA700,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30.0), // Apply border radius to the button
        ),
        child: const Text(
          "Reset Password",
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 18.0, // Font size
            fontWeight: FontWeight.bold, // Font weight
          ),
        ),
      ),
    );
  }

  Future _resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Email Sent'),
            content:
                Text("Password reset email sent! Please Check your email."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName(AppRoutes.loginScreen));
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.message.toString()),
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
