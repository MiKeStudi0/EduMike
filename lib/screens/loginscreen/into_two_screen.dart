import 'package:edumike/core/app_export.dart';
import 'package:flutter/material.dart';

class introTwoScreen extends StatefulWidget {
  const introTwoScreen({super.key});

  @override
  State<introTwoScreen> createState() => _introTwoScreenState();
}

class _introTwoScreenState extends State<introTwoScreen> {
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
                padding:  EdgeInsets.only(right: 60.v,),
                child: const Text(
                  "Select Your Details",
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
                    ImageConstant.cardTutorialadd,
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
                  "Add Your Card Details to get Your Course Access",
                
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
