import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/custom_drop_down_home.dart';
import 'package:edumike/widgets/custom_elevated_buttonHome.dart';
import 'package:edumike/widgets/custom_outlined_button_home.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AddUniversityCardScreen extends StatefulWidget {
  AddUniversityCardScreen({Key? key}) : super(key: key);

  @override
  State<AddUniversityCardScreen> createState() =>
      _AddUniversityCardScreenState();
}

class _AddUniversityCardScreenState extends State<AddUniversityCardScreen> {
  String? _selectedUniversityId;

  String? _selectedDegreeId;

  String? _selectedPropertyId;

  String? _selectedSemesterId;



  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList1 = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList2 = ["Item One", "Item Two", "Item Three"];

  List<String> dropdownItemList3 = ["Item One", "Item Two", "Item Three"];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: 
            SingleChildScrollView(
              child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 28.h, vertical: 25.v),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 101.h),
                            child: Text("Add Your Card",
                                style: theme.textTheme.titleLarge)),
                        SizedBox(height: 7.v),
                        _buildUniversity(context),
                        SizedBox(height: 13.v),
                        _buildDegree(context),
                        SizedBox(height: 20.v),
                        _buildCourse(context),
                        SizedBox(height: 25.v),
                        _buildSemester(context),
                        SizedBox(height: 28.v),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('/University')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> universitySnapshot) {
                            if (universitySnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (!universitySnapshot.hasData ||
                                universitySnapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text('No universities found'),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Select a University ID:',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text('Select a University ID'),
                                  value: _selectedUniversityId,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedUniversityId = newValue;
                                      _selectedDegreeId = null;
                                      _selectedPropertyId = null;
                                      _selectedSemesterId = null;
                                     
                                    });
                                  },
                                  items: universitySnapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    return DropdownMenuItem<String>(
                                      value: document.id,
                                      child: Text(
                                        document.id,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        // if (_selectedUniversityId != null)
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection(
                                  '/University/$_selectedUniversityId/Refers')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> degreeSnapshot) {
                            if (degreeSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (!degreeSnapshot.hasData ||
                                degreeSnapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text(
                                    'No degrees found for the selected university'),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Select a Degree:',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  hint: const Text('Select a Degree'),
                                  value: _selectedDegreeId,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedDegreeId = newValue;
                                      _selectedPropertyId = null;
                                      _selectedSemesterId = null;
                                                                     });
                                  },
                                  items: degreeSnapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    return DropdownMenuItem<String>(
                                      value: document.id,
                                      child: Text(
                                        document.id,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        if (_selectedDegreeId != null)
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(
                                    '/University/$_selectedUniversityId/Refers/$_selectedDegreeId/Refers')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> propertySnapshot) {
                              if (propertySnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (!propertySnapshot.hasData ||
                                  propertySnapshot.data!.docs.isEmpty) {
                                return const Center(
                                  child: Text(
                                      'No courses found for the selected degree'),
                                );
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Select a Course:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    hint: const Text('Select a Course'),
                                    value: _selectedPropertyId,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedPropertyId = newValue;
                                        _selectedSemesterId = null;
                                       
                                      });
                                    },
                                    items: propertySnapshot.data!.docs
                                        .map((DocumentSnapshot document) {
                                      return DropdownMenuItem<String>(
                                        value: document.id,
                                        child: Text(
                                          document.id,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              );
                            },
                          ),
                        const SizedBox(height: 20),
                        if (_selectedPropertyId != null)
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(
                                    '/University/$_selectedUniversityId/Refers/$_selectedDegreeId/Refers/$_selectedPropertyId/Refers')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> semesterSnapshot) {
                              if (semesterSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (!semesterSnapshot.hasData ||
                                  semesterSnapshot.data!.docs.isEmpty) {
                                return const Center(
                                  child: Text(
                                      'No semesters found for the selected course'),
                                );
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Select a Semester:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  DropdownButton<String>(
                                    isExpanded: true,
                                    hint: const Text('Select a Semester'),
                                    value: _selectedSemesterId,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedSemesterId = newValue;
                                   
                                      });
                                    },
                                    items: semesterSnapshot.data!.docs
                                        .map((DocumentSnapshot document) {
                                      return DropdownMenuItem<String>(
                                        value: document.id,
                                        child: Text(
                                          document.id,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              );
                            },
                          ),
                        _buildCancel(context),
                        SizedBox(height: 5.v)
                      ])),
            )));
  }

  /// Section Widget
  Widget _buildUniversity(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.h, right: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("University",
              style: CustomTextStyles.titleMediumMontserratBluegray900),
          SizedBox(height: 6.v),
          CustomDropDown(
              hintText: "Select  University",
              items: dropdownItemList,
              onChanged: (value) {})
        ]));
  }

  /// Section Widget
  Widget _buildDegree(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.h, right: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Degree",
              style: CustomTextStyles.titleMediumMontserratBluegray900),
          SizedBox(height: 6.v),
          CustomDropDown(
              hintText: "Select Degree",
              items: dropdownItemList1,
              onChanged: (value) {})
        ]));
  }

  /// Section Widget
  Widget _buildCourse(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.h, right: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Course",
              style: CustomTextStyles.titleMediumMontserratBluegray900),
          SizedBox(height: 7.v),
          CustomDropDown(
              hintText: "Select Course",
              items: dropdownItemList2,
              onChanged: (value) {})
        ]));
  }

  /// Section Widget
  Widget _buildSemester(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 12.h, right: 25.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Semester",
              style: CustomTextStyles.titleMediumMontserratBluegray900),
          SizedBox(height: 7.v),
          CustomDropDown(
              hintText: "Select Semester",
              items: dropdownItemList3,
              onChanged: (value) {})
        ]));
  }

  /// Section Widget
  Widget _buildCancel(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 13.h),
        child: Row(children: [
          CustomOutlinedButton(
              width: 140.h,
              text: "Cancel",
              onPressed: () {
                onTapCancel(context);
              }),
          CustomElevatedButton(
              width: 206.h,
              text: "Yes, Change",
              margin: EdgeInsets.only(left: 13.h),
              onPressed: () {
                onTapYesChange(context);
              })
        ]));
  }

  /// Navigates to the homemainpageContainerScreen when the action is triggered.
  onTapCancel(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
  }

  /// Navigates to the homemainpageContainerScreen when the action is triggered.
  onTapYesChange(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homemainpageContainerScreen);
  }
}
