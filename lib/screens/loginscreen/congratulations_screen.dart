import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: false,
        backgroundColor: theme.colorScheme.onErrorContainer,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            color: theme.colorScheme.onErrorContainer,
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.img11Congratulations,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 34.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5.v),
                _buildProcessColumn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildProcessColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(41.h),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(left: 18.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgSignal,
                    height: 18.adaptSize,
                    width: 18.adaptSize,
                    margin: EdgeInsets.only(
                      top: 105.v,
                      bottom: 53.v,
                    ),
                  ),
                  Container(
                    height: 176.v,
                    width: 164.h,
                    margin: EdgeInsets.only(left: 14.h),
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgBrightness,
                          height: 33.v,
                          width: 25.h,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 24.h),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgCloseTeal700,
                          height: 33.v,
                          width: 25.h,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                            left: 49.h,
                            top: 9.v,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 153.adaptSize,
                            width: 153.adaptSize,
                            margin: EdgeInsets.only(bottom: 1.v),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 152.adaptSize,
                                    width: 152.adaptSize,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 22.h),
                                    decoration: AppDecoration.fillAmberA,
                                    child: CustomImageView(
                                      imagePath: ImageConstant.imgGroup5,
                                      height: 70.v,
                                      width: 107.h,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.imgContrast,
                                  height: 31.v,
                                  width: 36.h,
                                  alignment: Alignment.bottomCenter,
                                  margin: EdgeInsets.only(bottom: 25.v),
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.imgImage9,
                                  height: 153.adaptSize,
                                  width: 153.adaptSize,
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgTriangle,
                          height: 14.adaptSize,
                          width: 14.adaptSize,
                          alignment: Alignment.bottomLeft,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 8.adaptSize,
                            width: 8.adaptSize,
                            margin: EdgeInsets.only(
                              left: 1.h,
                              bottom: 41.v,
                            ),
                            decoration: BoxDecoration(
                              color: appTheme.teal700,
                              borderRadius: BorderRadius.circular(
                                4.h,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 12.adaptSize,
                            width: 12.adaptSize,
                            margin: EdgeInsets.only(
                              left: 1.h,
                              top: 37.v,
                            ),
                            decoration: BoxDecoration(
                              color: appTheme.orangeA700,
                              borderRadius: BorderRadius.circular(
                                6.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 7.h,
                      top: 16.v,
                      bottom: 97.v,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgSignalErrorcontainer,
                          height: 18.adaptSize,
                          width: 18.adaptSize,
                          alignment: Alignment.centerRight,
                        ),
                        SizedBox(height: 33.v),
                        Container(
                          height: 12.adaptSize,
                          width: 12.adaptSize,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(
                              6.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgTriangleTeal700,
                    height: 14.adaptSize,
                    width: 14.adaptSize,
                    margin: EdgeInsets.only(
                      left: 16.h,
                      top: 87.v,
                      bottom: 75.v,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 29.v),
          Text(
            "Congratulations",
            style: theme.textTheme.headlineSmall,
          ),
          SizedBox(height: 10.v),
          SizedBox(
            width: 276.h,
            child: Text(
              "Your Account is Ready to Use. You will be redirected to the Home Page in a Few Seconds.",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall,
            ),
          ),
          SizedBox(height: 25.v),
          CustomImageView(
            imagePath: ImageConstant.imgUser,
            height: 40.adaptSize,
            width: 40.adaptSize,
          ),
          SizedBox(height: 8.v),
        ],
      ),
    );
  }
}

