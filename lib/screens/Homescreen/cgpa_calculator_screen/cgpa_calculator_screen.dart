// import 'package:edumike/theme/theme_helper.dart';
// import 'package:flutter/material.dart';

// class CGPACalculatorPage extends StatefulWidget {
//   @override
//   _CGPACalculatorPageState createState() => _CGPACalculatorPageState();
// }

// class _CGPACalculatorPageState extends State<CGPACalculatorPage> {
//   List<double> sgpaList = List<double>.filled(8, 0.0);
//   int filledFields = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appTheme.gray5002,
//       appBar: AppBar(
//         title: const Text('CGPA Calculator'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const Text(
//                 'Enter SGPA for each semester:',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               for (int i = 0; i < 8; i++)
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 10.0),
//                   child: Row(
//                     children: <Widget>[
//                       Text(
//                         'Semester ${i + 1}:',
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: TextField(
//                           keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                           onChanged: (value) {
//                             sgpaList[i] = double.tryParse(value) ?? 0.0;
//                             if (value.isNotEmpty) {
//                               filledFields = sgpaList.where((sgpa) => sgpa != 0.0).length;
//                             } else {
//                               filledFields = 0;
//                             }
//                           },
//                           decoration: const InputDecoration(
//                             labelText: 'SGPA',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   double totalSGPA = sgpaList.reduce((value, element) => value + element);
//                   double cgpa = totalSGPA / filledFields;
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: const Text('Your CGPA is:'),
//                       content: Text(cgpa.toStringAsFixed(2)),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text('Close'),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text('Calculate CGPA',style:TextStyle(color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }