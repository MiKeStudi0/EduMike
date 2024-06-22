import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';

class IntroOneScreen extends StatelessWidget {
  const IntroOneScreen({super.key});

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
          padding:  EdgeInsets.symmetric(horizontal: 65.h, vertical: 100.v),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Add Your Card Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
               SizedBox(height: 2.h),
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
                    ImageConstant.cardTutorial,
                    height: 500,
                    width: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
               SizedBox(height: 9.h),
               Padding(
                 padding:  EdgeInsets.only(left: 1.v,right: 9.v,bottom: 9.h),
                 child: Text(
                  "First Click Here to Add Your Card Details",
                
                  style: TextStyle(
                    color: Colors.white,
                       fontSize: theme.textTheme.titleSmall?.fontSize ?? 0),
                               ),
               ),
               SizedBox(height: 20.h),
          
            ],
          ),
        ),
      ),
    );
  }
}
