// import 'package:edumike/theme/theme_helper.dart';
// import 'package:flutter/material.dart';

// class SGPCalculatorPage extends StatefulWidget {
//   @override
//   _SGPCalculatorPageState createState() => _SGPCalculatorPageState();
// }

// class _SGPCalculatorPageState extends State<SGPCalculatorPage> {
//   List<double?> grades = List<double?>.filled(8, null);
//   List<int> credits = List<int>.filled(8, 0);

//   List<DropdownMenuItem<double>> buildGradeDropdownItems() {
//     List<DropdownMenuItem<double>> items = [];
//     List<double> gradePoints = [10.0, 9.0, 8.5, 8.0, 7.0, 6.0, 5.0, 0.0];
//     List<String> gradeDescriptions = ['S', 'A+', 'A', 'B+', 'B', 'C', 'P', 'F'];

//     for (int i = 0; i < gradePoints.length; i++) {
//       items.add(
//         DropdownMenuItem(
//           value: gradePoints[i],
//           child: Text('${gradeDescriptions[i]} (${gradePoints[i]})'),
//         ),
//       );
//     }

//     return items;
//   }

//   List<Widget> buildGradeCreditInputs() {
//     List<Widget> inputFields = [];

//     for (int i = 0; i < 8; i++) {
//       inputFields.add(
//         Row(
//           children: [
//             Expanded(
//               child: DropdownButtonFormField<double>(
//                 decoration: InputDecoration(
//                   border: const OutlineInputBorder(),
//                   labelText: 'Grade ${i + 1}',
//                 ),
//                 value: grades[i],
//                 items: buildGradeDropdownItems(),
//                 onChanged: (value) {
//                   setState(() {
//                     grades[i] = value;
//                   });
//                 },
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: TextField(
//                 onChanged: (value) {
//                   setState(() {
//                     credits[i] = int.tryParse(value) ?? 0;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   border: const OutlineInputBorder(),
//                   labelText: 'Credit ${i + 1}',
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//             ),
//           ],
//         ),
//       );
//       inputFields.add(const SizedBox(height: 10));
//     }

//     return inputFields;
//   }

//   double? calculateSGPA() {
//     double totalScore = 0;
//     int totalCredits = 0;

//     for (int i = 0; i < 8; i++) {
//       if (grades[i] != null) {
//         totalScore += grades[i]! * credits[i];
//         totalCredits += credits[i];
//       }
//     }

//     return totalScore / totalCredits;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appTheme.gray5002,
//       appBar: AppBar(
//         title: const Text('SGPA Calculator'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const Text(
//                 'Enter Grades and Credits:',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               Column(
//                 children: buildGradeCreditInputs(),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   double? sgpa = calculateSGPA();
//                   if (sgpa != null && !sgpa.isNaN) {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Your SGPA is:'),
//                         content: Text(sgpa.toStringAsFixed(2)),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('Close'),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else {
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Error'),
//                         content: const Text('Please fill all the grade boxes.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text('OK'),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text('Calculate SGPA',style:TextStyle(color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }