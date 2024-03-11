// import 'package:edumike/core/app_export.dart';
// import 'package:edumike/widgets/app_bar/appbar_leading_image_home.dart';
// import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
// import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
// import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:contacts_service/contacts_service.dart';





// class InviteFriendsScreen extends StatefulWidget {
//    InviteFriendsScreen({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
// }

// class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
// List<Contact> contacts = [];

//   @override
//   void initState(){
//     super.initState();
//     getAllContacts();
//   }

// getAllContacts()async{
// List<Contact> _contacts = await ContactsService.getContacts(withThumbnails: false);
// setState(() {
//   contacts=_contacts;
// });
// }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: appTheme.whiteA700,
//         appBar: _buildAppBar(context),
//         body: Container(
        
//           width: double.maxFinite,
//           padding: EdgeInsets.symmetric(
//             horizontal: 34.h,
//             vertical: 23.v,
//           ),
//           child: Column(
            
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ListView.builder(
//                 itemCount: contacts.length, itemBuilder: (BuildContext context, int index) { 
//                   Contact contact = contacts[index];
//                   return ListTile(
//                     title: Text(contact.displayName?? ''),
//                     subtitle: Text(
//                       contact.phones?.elementAt(0).value?? ''
//                     ),
//                   );
//                  },

    
//   ),
              
//              // _buildInvite(context),
//               SizedBox(height: 15.v),
//               Text(
//                 "Share Invite Via",
//                 style: CustomTextStyles.titleMedium18,
//               ),
//               SizedBox(height: 15.v),
//               Padding(
//                 padding: EdgeInsets.only(right: 162.h),
//                 child: Row(
//                   children: [
//                    GestureDetector(
//   onTap: () {
//     // Handle tap on the Facebook image
//     share('Facebook');
//   },

//   child: CustomImageView(
//     imagePath: ImageConstant.imgFacebook,
//     height: 25.v,
//     width: 25.h,
//     margin: EdgeInsets.only(top: 3.v),
//   ),
// ),
// const Spacer(
//   flex: 33,
// ),
// GestureDetector(
//   onTap: () {
//     // Handle tap on the Trash image
//     share('Twitter');
//   },
//   child: CustomImageView(
//     imagePath: ImageConstant.imgTrash,
//     height: 25.v,
//     width: 25.h,
//     margin: EdgeInsets.only(top: 3.v, bottom: 2.v),
//   ),
// ),
// const Spacer(
//   flex: 33,
// ),
// GestureDetector(
//   onTap: () {
//     // Handle tap on the Google image
//     share('Gmail');
//   },
//   child: CustomImageView(
//     imagePath: ImageConstant.imgGoogle,
//     height: 25.v,
//     width: 25.h,
//     margin: EdgeInsets.only(top: 3.v),
//   ),
// ),
// const Spacer(
//   flex: 33,
// ),
// GestureDetector(
//   onTap: () {
//     // Handle tap on the whatsappimage
//     share('WhatsApp');
//   },
//   child: CustomImageView(
//     imagePath: ImageConstant.imgVolume,
//     height: 25.v,
//     width: 25.h,
//     margin: EdgeInsets.only(top: 3.v),
//   ),
// ),
       
//                   ],
//                 ),
//               ),
//               SizedBox(height: 5.v),
//             ],
//           ),
//         ),
    
//       ),
      
//     );
//   }

// void share(var appName) async {
//   // The subject of the message
//   const String subject = "Check out this amazing app!";

//   // The body of the message, including the URL
//   const String body = "Hey there,\n\nCheck out this amazing app: https://www.example.com";

//   // The URL scheme for composing a message
//   var url;
//   if (appName == 'WhatsApp') {
//     url = "https://wa.me/?text=${Uri.encodeComponent('$subject\n\n$body')}";
//   } else if (appName == 'Gmail') {
//     url = "mailto:?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}";
//   }else if (appName == 'Facebook') {
//   url = "https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(url)}";
//   }else if (appName == 'Twitter') {
//   url = "https://twitter.com/intent/tweet?text=${Uri.encodeComponent('$subject\n\n$body')}";
// }else if (appName == 'LinkedIn') {
//   url = "https://www.linkedin.com/shareArticle?mini=true&url=${Uri.encodeComponent(url)}&title=${Uri.encodeComponent(subject)}&summary=${Uri.encodeComponent(body)}";
// }

//   // ignore: deprecated_member_use
//   if (await canLaunch(url)) {
//     // ignore: deprecated_member_use
//     await launch(url);
//   } else {
//     print("Error sharing via $appName");
//   }
// }

//   /// Section Widget
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//       leadingWidth: 61.h,
//       leading: AppbarLeadingImage(
//         imagePath: ImageConstant.imgArrowDown,
//         margin: EdgeInsets.only(
//           left: 35.h,
//           top: 18.v,
//           bottom: 17.v,
//         ),
//       ),
//       title: AppbarSubtitle(
//         text: "Invite Friends",
//         margin: EdgeInsets.only(left: 12.h),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildInviteButton1(BuildContext context) {
//     return CustomElevatedButton(
//       height: 28.v,
//       width: 80.h,
//       text: "Invite",
//       margin: EdgeInsets.only(
//         top: 14.v,
//         bottom: 8.v,
//       ),
//       buttonStyle: CustomButtonStyles.fillPrimary,
//       buttonTextStyle: CustomTextStyles.labelLargeMulishWhiteA700,
//     );
//   }


//   /// Common widget
//   Widget _buildDominickSJenkins(
//     BuildContext context, {
//     required String userName,
//     required String phoneNumber
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
        
//         Text(
//           userName,
//           style: theme.textTheme.titleMedium!.copyWith(
//             color: appTheme.blueGray90001,
//           ),
//         ),
//         Text(
//           phoneNumber,
//           style:
//               CustomTextStyles.labelLargeMulishSecondaryContainerBold.copyWith(
//             color: theme.colorScheme.secondaryContainer,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class InviteFriendsScreen extends StatefulWidget {
  InviteFriendsScreen({Key? key}) : super(key: key);

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _requestContactsPermission();
  }

  Future<void> _requestContactsPermission() async {
    if (await Permission.contacts.request().isGranted) {
      _getAllContacts();
    } else {
      // Handle the scenario if permission is denied
      print('Contacts permission is denied');
    }
  }

  Future<void> _getAllContacts() async {
    List<Contact> _contacts = await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Invite Friends'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    Contact contact = contacts[index];
                    return ListTile(
                      title: Text(contact.displayName ?? ''),
                      subtitle: Text(contact.phones?.elementAt(0).value ?? ''),
                    );
                  },
                ),
              ),
              SizedBox(height: 15.0),
              Text(
                "Share Invite Via",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSocialMediaIcon('Facebook', 'https://www.facebook.com/sharer/sharer.php?u=https://www.example.com'),
                  _buildSocialMediaIcon('Twitter', 'https://twitter.com/intent/tweet?text=Check out this amazing app: https://www.example.com'),
                  _buildSocialMediaIcon('Gmail', 'mailto:?subject=Check out this amazing app!&body=Hey there,\n\nCheck out this amazing app: https://www.example.com'),
                  _buildSocialMediaIcon('WhatsApp', 'https://wa.me/?text=Check out this amazing app: https://www.example.com'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaIcon(String appName, String url) {
    return GestureDetector(
      onTap: () {
        _share(appName, url);
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/$appName.png', // You need to provide the images for social media icons
          width: 50.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> _share(String appName, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Error sharing via $appName");
    }
  }
}
