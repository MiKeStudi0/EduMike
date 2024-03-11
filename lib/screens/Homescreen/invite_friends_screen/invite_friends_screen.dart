import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image_home.dart';
import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 34.h,
            vertical: 23.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // _buildInvite(context),
              SizedBox(height: 15.v),
              Text(
                "Share Invite Via",
                style: CustomTextStyles.titleMedium18,
              ),
              SizedBox(height: 15.v),
              Padding(
                padding: EdgeInsets.only(right: 162.h),
                child: Row(
                  children: [
                   GestureDetector(
  onTap: () {
    // Handle tap on the Facebook image
    share('Facebook');
  },
  child: CustomImageView(
    imagePath: ImageConstant.imgFacebook,
    height: 25.v,
    width: 25.h,
    margin: EdgeInsets.only(top: 3.v),
  ),
),
const Spacer(
  flex: 33,
),
GestureDetector(
  onTap: () {
    // Handle tap on the Trash image
    share('Twitter');
  },
  child: CustomImageView(
    imagePath: ImageConstant.imgTrash,
    height: 25.v,
    width: 25.h,
    margin: EdgeInsets.only(top: 3.v, bottom: 2.v),
  ),
),
const Spacer(
  flex: 33,
),
GestureDetector(
  onTap: () {
    // Handle tap on the Google image
    share('Gmail');
  },
  child: CustomImageView(
    imagePath: ImageConstant.imgGoogle,
    height: 25.v,
    width: 25.h,
    margin: EdgeInsets.only(top: 3.v),
  ),
),
const Spacer(
  flex: 33,
),
GestureDetector(
  onTap: () {
    // Handle tap on the whatsappimage
    share('WhatsApp');
  },
  child: CustomImageView(
    imagePath: ImageConstant.imgVolume,
    height: 25.v,
    width: 25.h,
    margin: EdgeInsets.only(top: 3.v),
  ),
),
       
                  ],
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

void share(var appName) async {
  // The subject of the message
  const String subject = "Check out this amazing app!";

  // The body of the message, including the URL
  const String body = "Hey there,\n\nCheck out this amazing app: https://www.example.com";

  // The URL scheme for composing a message
  var url;
  if (appName == 'WhatsApp') {
    url = "https://wa.me/?text=${Uri.encodeComponent('$subject\n\n$body')}";
  } else if (appName == 'Gmail') {
    url = "mailto:?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}";
  }else if (appName == 'Facebook') {
  url = "https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(url)}";
  }else if (appName == 'Twitter') {
  url = "https://twitter.com/intent/tweet?text=${Uri.encodeComponent('$subject\n\n$body')}";
}else if (appName == 'LinkedIn') {
  url = "https://www.linkedin.com/shareArticle?mini=true&url=${Uri.encodeComponent(url)}&title=${Uri.encodeComponent(subject)}&summary=${Uri.encodeComponent(body)}";
}

  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    print("Error sharing via $appName");
  }
}

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 61.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowDown,
        margin: EdgeInsets.only(
          left: 35.h,
          top: 18.v,
          bottom: 17.v,
        ),
      ),
      title: AppbarSubtitle(
        text: "Invite Friends",
        margin: EdgeInsets.only(left: 12.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildInviteButton1(BuildContext context) {
    return CustomElevatedButton(
      height: 28.v,
      width: 80.h,
      text: "Invite",
      margin: EdgeInsets.only(
        top: 14.v,
        bottom: 8.v,
      ),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.labelLargeMulishWhiteA700,
    );
  }

  /// Section Widget
      
  /// Common widget
  Widget _buildDominickSJenkins(
    BuildContext context, {
    required String userName,
    required String phoneNumber,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName,
          style: theme.textTheme.titleMedium!.copyWith(
            color: appTheme.blueGray90001,
          ),
        ),
        Text(
          phoneNumber,
          style:
              CustomTextStyles.labelLargeMulishSecondaryContainerBold.copyWith(
            color: theme.colorScheme.secondaryContainer,
          ),
        ),
      ],
    );
  }
}
