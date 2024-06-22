import 'package:edumike/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewhierarchyItemWidget extends StatelessWidget {
  ViewhierarchyItemWidget({
    super.key,
    this.onTapTxtSubscribeText,
  });

  VoidCallback? onTapTxtSubscribeText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 13.h,
        vertical: 21.v,
      ),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 195.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 52.v,
                  width: 56.h,
                  margin: EdgeInsets.only(top: 1.v),
                  decoration: BoxDecoration(
                    color: appTheme.whiteA700,
                    borderRadius: BorderRadius.circular(
                      20.h,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: appTheme.black900.withOpacity(0.1),
                        spreadRadius: 2.h,
                        blurRadius: 2.h,
                        offset: const Offset(
                          1,
                          3,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Subscription1.!",
                        style: CustomTextStyles.titleMedium19,
                      ),
                      SizedBox(height: 4.v),
                      Text(
                        "Description..",
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onTapTxtSubscribeText!.call();
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: 13.v,
                right: 14.h,
                bottom: 22.v,
              ),
              child: Text(
                "Subscribe",
                style: CustomTextStyles.titleSmallPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
