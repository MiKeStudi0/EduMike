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
//                 shrinkWrap:true,
//                 itemCount: 15,
//                  itemBuilder: (BuildContext context, int index) { 
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




import 'package:edumike/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:url_launcher/url_launcher.dart';

class InviteFriendsScreen extends StatefulWidget {
  @override
  _InviteFriendsScreenState createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  List<Contact> _contacts = [];
  int _displayedContactsCount = 15; // Initially display 15 contacts
  bool _loading = true;


  @override
  void initState() {
    super.initState();
    _requestContactsPermission();
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
  void _requestContactsPermission() async {
    if (await Permission.contacts.request().isGranted) {
      _getAllContacts();
    } else {
      // Handle the scenario if permission is denied
      print('Contacts permission is denied');
    }
  }
   Future<void> _getAllContacts() async {
    List<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
      _loading = false; // Set loading to false once contacts are loaded
    });
  }

 Future<void> _sendInvite(String phoneNumber) async {
    // Define your predefined message
    String message =
        'Hey! Join me on this cool app! Here\'s a YouTube video you might like: https://www.youtube.com/watch?v=YOUR_VIDEO_ID';

    // Encode the message and phone number for use in the URL
    String encodedMessage = Uri.encodeComponent(message);
    String encodedPhoneNumber = Uri.encodeComponent(phoneNumber);

    // Construct the URL for sending SMS
    String uri = 'sms:$encodedPhoneNumber?body=$encodedMessage';

    // Launch the SMS application with the predefined message and phone number
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // Handle error
      print('Could not launch $uri');
    }
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Invite Friends'),
    ),
    body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: double.infinity,
              height: 650,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: Container(
                      width: 300, // Set a fixed width for the container
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black), // Add a border
                      ),
                      child: ListView.builder(
                        itemCount: _displayedContactsCount,
                        itemBuilder: (context, index) {
                          Contact contact = _contacts[index];
                          String phoneNumber = contact.phones?.isNotEmpty == true ? contact.phones!.first.value! : '';

                          return Column(
                            children: [
                              ListTile(
                                title: Text(contact.displayName ?? ''),
                                subtitle: Text(phoneNumber),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    _sendInvite(phoneNumber);
                                  },
                                  child: const Text('Invite', style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 1.0,
                                color: Colors.black,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  if (_displayedContactsCount < _contacts.length)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          // Increase the number of displayed contacts by 15 when 'Load More' is pressed
                          _displayedContactsCount += 15;
                        });
                      },
                      child: Text('Load More'),
                    ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),

  bottomNavigationBar: Container(
  height: 150,
  padding: const EdgeInsets.all(16.0),
  color: Colors.grey.shade200,
  child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Invite Via',
        style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),
      ),
      const SizedBox(height: 16.0),
      Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          
          GestureDetector(
            onTap: () {
              share('Facebook');
              // Handle onTap event for the first image
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomImageView(
                imagePath: ImageConstant.imgFacebook,
                width: 30, // Set width here
                height: 30, // Set height here
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              share('Twitter');
              // Handle onTap event for the second image
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomImageView(
                imagePath: ImageConstant.imgTrash,
                width: 30, // Set width here
                height: 30, // Set height here
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
               share('Gmail');
              // Handle onTap event for the third image
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomImageView(
                imagePath: ImageConstant.imgGoogle,
                width: 30, // Set width here
                height: 30, // Set height here
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              share('WhatsApp');
              // Handle onTap event for the fourth image
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomImageView(
                imagePath: ImageConstant.imgVolume,
                width: 30, // Set width here
                height: 30, // Set height here
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16.0),
    ],
  ),
),


  );
}


}
