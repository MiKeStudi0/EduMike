import 'package:edumike/screens/homescren/homepage.dart';
import 'package:flutter/material.dart';
import 'package:edumike/screens/loginscreen/intro_one_screen.dart';
import 'package:edumike/screens/loginscreen/let_s_you_in_screen.dart';
import 'package:edumike/screens/loginscreen/register_now_screen.dart';
import 'package:edumike/screens/loginscreen/login_screen.dart';
import 'package:edumike/screens/loginscreen/fill_your_profile_screen.dart';
import 'package:edumike/screens/loginscreen/congratulations_screen.dart';
import 'package:edumike/screens/loginscreen/forgot_password_screen.dart';
import 'package:edumike/screens/loginscreen/verify_mail_screen.dart';
import 'package:edumike/screens/loginscreen/create_new_password_screen.dart';
import 'package:edumike/screens/loginscreen/verify_forgot_password_one_screen.dart';
import 'package:edumike/screens/loginscreen/app_navigation_screen.dart';

class AppRoutes {
  static const String introOneScreen = '/intro_one_screen';

  static const String letSYouInScreen = '/let_s_you_in_screen';

  static const String registerNowScreen = '/register_now_screen';

  static const String homescreen = '/homepage';

  static const String loginScreen = '/login_screen';

  static const String fillYourProfileScreen = '/fill_your_profile_screen';

  static const String congratulationsScreen = '/congratulations_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String verifyMailScreen = '/verify_mail_screen';

  static const String createNewPasswordScreen = '/create_new_password_screen';

  static const String verifyForgotPasswordOneScreen =
      '/verify_forgot_password_one_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    introOneScreen: (context) => const IntroOneScreen(),
    letSYouInScreen: (context) => const LetSYouInScreen(),
    registerNowScreen: (context) => RegisterNowScreen(),
    loginScreen: (context) => LoginScreen(),
    homescreen: (context) => const Homescreen(),
    fillYourProfileScreen: (context) => FillYourProfileScreen(),
    congratulationsScreen: (context) => CongratulationsScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    verifyMailScreen: (context) => VerifyMailScreen(),
    createNewPasswordScreen: (context) => CreateNewPasswordScreen(),
    verifyForgotPasswordOneScreen: (context) => VerifyForgotPasswordOneScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
