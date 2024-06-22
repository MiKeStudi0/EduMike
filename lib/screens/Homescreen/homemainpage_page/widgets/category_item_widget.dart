import 'package:edumike/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58.h,
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 6.v,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder15,
      ),
      child: Text(
        "All",
        style: CustomTextStyles.labelLargeMulishWhiteA700,
      ),
    );
  }
}
