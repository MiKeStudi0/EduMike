import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class introThreeScreen extends StatefulWidget {
  const introThreeScreen({super.key});

  @override
  State<introThreeScreen> createState() => _introThreeScreenState();
}

class _introThreeScreenState extends State<introThreeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray50,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 15, 79, 184),
                Color.fromARGB(255, 68, 156, 228),
              ],
            ),
          ),
          padding:  EdgeInsets.symmetric(horizontal: 40.h, vertical: 90.v),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding:  EdgeInsets.only(right: 20.v,),
                child: const Text(
                  "Now Course Available",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
               SizedBox(height: 6.h),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    ImageConstant.cardTutorialadded,
                    height: 500,
                    width: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
               SizedBox(height: 10.h),
               Padding(
                 padding:  EdgeInsets.only(left: 28.v,right: 9.v,bottom: 9.h),
                 child: Text(
                  "Now You Can Access Your Courses At Anytime And Start Learning",
                
                  style: TextStyle(
                    color: Colors.white,
                       fontSize: theme.textTheme.titleSmall?.fontSize ?? 0),
                               ),
               ),
               SizedBox(height: 20.h),
          
            ],
          ),
        ),
      ));
  }
}
