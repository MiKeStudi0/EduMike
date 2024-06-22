// import 'package:edumike/core/app_export.dart';
// import 'package:edumike/widgets/custom_icon_button_home.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class TodaysectionlistItemWidget extends StatelessWidget {
//   const TodaysectionlistItemWidget({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       clipBehavior: Clip.antiAlias,
//       elevation: 0,
//       margin: EdgeInsets.all(0),
//       color: appTheme.blue50,
//       shape: RoundedRectangleBorder(
//         side: BorderSide(
//           color: appTheme.blueGray200.withOpacity(0.2),
//           width: 2.h,
//         ),
//         borderRadius: BorderRadiusStyle.roundedBorder18,
//       ),
//       child: Container(
//         height: 100.v,
//         width: 360.h,
//         padding: EdgeInsets.symmetric(
//           horizontal: 16.h,
//           vertical: 19.v,
//         ),
//         decoration: AppDecoration.outlineBlueGray.copyWith(
//           borderRadius: BorderRadiusStyle.roundedBorder18,
//         ),
//         child: Stack(
//           alignment: Alignment.topLeft,
//           children: [
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   right: 18.h,
//                   bottom: 4.v,
//                 ),
//                 child: Text(
//                   "New the 3D Design Course is Availa..",
//                   style: theme.textTheme.titleSmall,
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomIconButton(
//                     height: 52.adaptSize,
//                     width: 52.adaptSize,
//                     padding: EdgeInsets.all(16.h),
//                     child: CustomImageView(
//                       imagePath: ImageConstant.imgGrid,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       left: 8.h,
//                       top: 3.v,
//                       bottom: 20.v,
//                     ),
//                     child: Text(
//                       "New Category Course.!",
//                       style: CustomTextStyles.titleMedium19,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class NewPage extends StatelessWidget {
//   const NewPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('New Page'),
//       ),
//       body: Center(
//         child: Container(
//           height: 100,
//           width: 360,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
//           decoration: BoxDecoration(
//             color: Colors.blue[50],
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(
//               color: Colors.blueGrey[200]!.withOpacity(0.2),
//               width: 2,
//             ),
//           ),
//           child: Stack(
//             alignment: Alignment.topLeft,
//             children: [
//               const Align(
//                 alignment: Alignment.bottomRight,
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 18, bottom: 4),
//                   child: Text(
//                     "New the 3D Design Course is Available",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 52,
//                       width: 52,
//                       padding: const EdgeInsets.all(16),
//                       // child: Image.network(
//                       //   'https://via.placeholder.com/150', // Example image URL
//                       //   fit: BoxFit.cover,
//                       // ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(left: 8, top: 3, bottom: 20),
//                       child: Text(
//                         "New Category Course!",
//                         style: TextStyle(
//                           fontSize: 19,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class NotificationDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  const NotificationDetailScreen({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

