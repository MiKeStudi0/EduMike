import 'package:edumike/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserprofileItemWidget extends StatelessWidget {
  UserprofileItemWidget({
    super.key,
    this.onTapBackgroundImage,
  });

  VoidCallback? onTapBackgroundImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.h,
      child: Padding(
        padding: EdgeInsets.only(top: 5.v),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                onTapBackgroundImage!.call();
              },
              child: Container(
                height: 70.v,
                width: 80.h,
                decoration: BoxDecoration(
                  color: appTheme.black900,
                  borderRadius: BorderRadius.circular(
                    20.h,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(
              height: 19.v,
              width: 31.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "item1",
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "item1",
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
