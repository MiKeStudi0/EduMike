import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppNotificationsScreen extends StatefulWidget {
  const AppNotificationsScreen({Key? key}) : super(key: key);

  @override
  _AppNotificationsScreenState createState() => _AppNotificationsScreenState();
}

class _AppNotificationsScreenState extends State<AppNotificationsScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  List<String> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
    _setupFirebaseMessaging();
  }

  void _setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.notification?.title}");
      setState(() {
        _notifications.add(_getMessageText(message));
        _saveNotifications();
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: ${message.notification?.title}");
      setState(() {
        _notifications.add(_getMessageText(message));
        _saveNotifications();
      });
    });

    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
    });
  }

  Future<void> _loadNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notifications = prefs.getStringList('notifications') ?? [];
    });
  }

  Future<void> _saveNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('notifications', _notifications);
  }

  String _getMessageText(RemoteMessage message) {
    // Extract notification text from message
    String title = message.notification?.title ?? '';
    String body = message.notification?.body ?? '';
    return '$title: $body';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 17,right: 17,bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 153, 193, 227),
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                leading: const Icon(Icons.notification_important), // Icon before text
                title: Text(
                  _notifications[index].split(":")[0], // Extracting title
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  _notifications[index].split(":")[1].trim(), // Extracting text
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}





// import 'package:firebase_messaging/firebase_messaging.dart';

// import '../app_notifications_screen/widgets/todaysectionlist_item_widget.dart';
// import 'package:edumike/core/app_export.dart';
// import 'package:edumike/widgets/app_bar/appbar_leading_image_home.dart';
// import 'package:edumike/widgets/app_bar/appbar_subtitle.dart';
// import 'package:edumike/widgets/app_bar/custom_app_bar_home.dart';
// import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
// import 'package:flutter/material.dart';
// import 'package:grouped_list/grouped_list.dart';

// // ignore_for_file: must_be_immutable
// class AppNotificationsScreen extends StatelessWidget {
//     final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


//   //  @override
//   // void initState() {
//   //   // Initialize Firebase Messaging
//   //   _initializeFirebaseMessaging();
//   // }

//   void _initializeFirebaseMessaging() {
//     // Request permission for receiving messages
//     _firebaseMessaging.requestPermission();

//     // Listen to incoming messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("Message received: ${message.notification!.body}");
//       // Handle the received message, e.g., display a notification
//     });
//   }


//   AppNotificationsScreen({Key? key}) : super(key: key);

//   List todaysectionlistItemList = [
//     {'id': 1, 'groupBy': "Today"},
//     {'id': 4, 'groupBy': "Yesterday"},
//     {'id': 5, 'groupBy': "Nov 20, 2022"}
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             appBar: _buildAppBar(context),
//             body: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Container(
//                   width: double.maxFinite,
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 33.h, vertical: 2.v),
//                   child: Column(children: [
//                     _buildCategory(context),
//                     SizedBox(height: 15.v),
//                     _buildTodaySectionList(context),
//                     SizedBox(height: 5.v)
//                   ])),
//             )));
//   }

//   /// Section Widget
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return CustomAppBar(
//         leadingWidth: 61.h,
//         leading: AppbarLeadingImage(
//             imagePath: ImageConstant.imgArrowDown,
//             margin: EdgeInsets.only(left: 35.h, top: 18.v, bottom: 17.v),
//             onTap: () {
//               onTapArrowDown(context);
//             }),
//         title: AppbarSubtitle(
//             text: "Notifications", margin: EdgeInsets.only(left: 12.h)));
//   }

//   /// Section Widget
//   Widget _buildCategory(BuildContext context) {
//     return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//       Expanded(
//           child: CustomElevatedButton(
//               height: 48.v,
//               text: "App",
//               margin: EdgeInsets.only(right: 10.h),
//               buttonStyle: CustomButtonStyles.fillPrimaryTL24,
//               buttonTextStyle: CustomTextStyles.titleSmallWhiteA700)),
//       Expanded(
//           child: CustomElevatedButton(
//               height: 48.v,
//               text: "Subscription",
//               margin: EdgeInsets.only(left: 10.h),
//               buttonStyle: CustomButtonStyles.fillBlueTL24,
//               buttonTextStyle: CustomTextStyles.titleSmallBluegray90001,
//               onPressed: () {
//                 onTapSubscription(context);
//               }))
//     ]);
//   }

//   /// Section Widget
//   Widget _buildTodaySectionList(BuildContext context) {
//     return GroupedListView<dynamic, String>(
//         shrinkWrap: true,
//         stickyHeaderBackgroundColor: Colors.transparent,
//         elements: todaysectionlistItemList,
//         groupBy: (element) => element['groupBy'],
//         sort: false,
//         groupSeparatorBuilder: (String value) {
//           return Padding(
//               padding: EdgeInsets.only(top: 34.v, bottom: 18.v),
//               child: Text(value,
//                   style: CustomTextStyles.titleMediumBold
//                       .copyWith(color: appTheme.blueGray90001)));
//         },
//         itemBuilder: (context, model) {
//           return  TodaysectionlistItemWidget();
//         },
//         separator: SizedBox(height: 12.v));
//   }

//   /// Navigates to the homemainpageContainerScreen when the action is triggered.
//   onTapArrowDown(BuildContext context) {
//     Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
//   }

//   /// Navigates to the subscriptionNotificationsScreen when the action is triggered.
//   onTapSubscription(BuildContext context) {
//     Navigator.pushNamed(context, AppRoutes.subscriptionNotificationsScreen);
//   }
// }
