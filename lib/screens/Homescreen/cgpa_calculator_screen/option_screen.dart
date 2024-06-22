import 'package:edumike/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class GPAHomePage extends StatefulWidget {
  const GPAHomePage({super.key});

  @override
  _GPAHomePageState createState() => _GPAHomePageState();
}

class _GPAHomePageState extends State<GPAHomePage> {
  int _selectedIndex = 0;

  Color _buttonColor(int index) {
    return _selectedIndex == index ? Colors.blue : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray5002,
      appBar: AppBar(
        backgroundColor: appTheme.gray5002,
        title: const Text('GPA Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: _buttonColor(0),
                    minimumSize: const Size(150, 60),
                  ),
                  child: const Text('SGPA'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: _buttonColor(1),
                    minimumSize: const Size(150, 60),
                  ),
                  child: const Text('CGPA'),
                ),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
                SGPCalculatorPage(),
                CGPACalculatorPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class SGPCalculatorPage extends StatefulWidget {
  const SGPCalculatorPage({super.key});

  @override
  _SGPCalculatorPageState createState() => _SGPCalculatorPageState();
}

class _SGPCalculatorPageState extends State<SGPCalculatorPage> {
  List<double?> grades = List<double?>.filled(8, null);
  List<int> credits = List<int>.filled(8, 0);

  List<DropdownMenuItem<double>> buildGradeDropdownItems() {
    List<DropdownMenuItem<double>> items = [];
    List<double> gradePoints = [10.0, 9.0, 8.5, 8.0, 7.0, 6.0, 5.0, 0.0];
    List<String> gradeDescriptions = ['S', 'A+', 'A', 'B+', 'B', 'C', 'P', 'F'];

    for (int i = 0; i < gradePoints.length; i++) {
      items.add(
        DropdownMenuItem(
          value: gradePoints[i],
          child: Text('${gradeDescriptions[i]} (${gradePoints[i]})'),
        ),
      );
    }

    return items;
  }

  List<Widget> buildGradeCreditInputs() {
    List<Widget> inputFields = [];

    for (int i = 0; i < 8; i++) {
      inputFields.add(
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<double>(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Grade ${i + 1}',
                ),
                value: grades[i],
                items: buildGradeDropdownItems(),
                onChanged: (value) {
                  setState(() {
                    grades[i] = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    credits[i] = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Credit ${i + 1}',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      );
      inputFields.add(const SizedBox(height: 10));
    }

    return inputFields;
  }

  double? calculateSGPA() {
    double totalScore = 0;
    int totalCredits = 0;

    for (int i = 0; i < 8; i++) {
      if (grades[i] != null) {
        totalScore += grades[i]! * credits[i];
        totalCredits += credits[i];
      }
    }

    return totalScore / totalCredits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray5002,
      //appBar: AppBar(
        //title: const Text('SGPA Calculator'),
//),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Enter Grades and Credits:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Column(
                children: buildGradeCreditInputs(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  double? sgpa = calculateSGPA();
                  if (sgpa != null && !sgpa.isNaN) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Your SGPA is:'),
                        content: Text(sgpa.toStringAsFixed(2)),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please fill all the grade boxes.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Calculate SGPA',style:TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CGPACalculatorPage extends StatefulWidget {
  const CGPACalculatorPage({super.key});

  @override
  _CGPACalculatorPageState createState() => _CGPACalculatorPageState();
}

class _CGPACalculatorPageState extends State<CGPACalculatorPage> {
  List<double> sgpaList = List<double>.filled(8, 0.0);
  int filledFields = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray5002,
      // appBar: AppBar(
      //   title: const Text('CGPA Calculator'),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Enter SGPA for each semester:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              for (int i = 0; i < 8; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Semester ${i + 1}:',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onChanged: (value) {
                            sgpaList[i] = double.tryParse(value) ?? 0.0;
                            if (value.isNotEmpty) {
                              filledFields = sgpaList.where((sgpa) => sgpa != 0.0).length;
                            } else {
                              filledFields = 0;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'SGPA',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  double totalSGPA = sgpaList.reduce((value, element) => value + element);
                  double cgpa = totalSGPA / filledFields;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Your CGPA is:'),
                      content: Text(cgpa.toStringAsFixed(2)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Calculate CGPA',style:TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}