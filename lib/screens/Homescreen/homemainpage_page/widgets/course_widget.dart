import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';

class CourseWidget extends StatefulWidget {
  const CourseWidget({super.key});

  @override
  State<CourseWidget> createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  List<Map<String, dynamic>> documentsData = [];

  @override
  void initState() {
    super.initState();
    fetchDocumentsData();
  }

  Future<void> fetchDocumentsData() async {
    try {
      // Replace 'yourCollection' with the actual name of your collection
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(
              '/University/A.P.J. Abdul Kalam Technological University/Refers/B.Tech/Refers/Computer Science and Engineering/Refers/S1/Refers')
          .get();

      // Store document IDs and field data in the list
      for (var doc in snapshot.docs) {
        Map<String, dynamic> documentData =
            (doc.data() as Map<String, dynamic>);
        String documentId = doc.id;

        documentsData.add({
          'id': documentId,
          'courseCode': documentData,
        });
      }

      // Force a rebuild after fetching the document data
      setState(() {});
    } catch (e) {
      print("Error fetching document data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 224.5.h,
      width: 414.h,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 10.h);
          },
          scrollDirection: Axis.horizontal,
          itemCount: documentsData.length,
          itemBuilder: (BuildContext context, int index) {
            String documentId = documentsData[index]['id'];
            Map<String, dynamic> fieldData = documentsData[index]['courseCode'];
            print(fieldData);

            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: IntrinsicWidth(
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Add your onTap logic
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 240.v,
                              width: 280.h,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                          height: 240.v,
                                          width: 280.h,
                                          decoration: BoxDecoration(
                                              color: appTheme.whiteA700,
                                              borderRadius:
                                                  BorderRadius.circular(20.h),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: appTheme.black900
                                                        .withOpacity(0.08),
                                                    spreadRadius: 2.h,
                                                    blurRadius: 2.h,
                                                    offset: const Offset(0, 4))
                                              ]))),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: 134.v,
                                            width: 280.h,
                                            decoration: BoxDecoration(
                                                color: appTheme.black900,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            20.h)))),
                                        SizedBox(height: 10.v),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 15.h, right: 19.h),
                                            child: _buildGraphicDesign(context,
                                                text: "Syllabus")),
                                        SizedBox(height: 4.v),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 14.h, right: 19.h),
                                            child: Text(documentId,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: theme
                                                    .textTheme.titleMedium)),
                                        SizedBox(height: 9.v),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 13.h),
                                            child: _buildDetails(context,
                                                fortyTwoText:
                                                    "${fieldData['courseCredit']}",
                                                separatorText: "|",
                                                stdCounterText:
                                                    fieldData['courseCode'])),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget _buildDetails(
    BuildContext context, {
    required String fortyTwoText,
    required String separatorText,
    required String stdCounterText,
  }) {
    return Row(children: [
      Container(
          width: 32.h,
          margin: EdgeInsets.only(top: 3.v),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomImageView(
                imagePath: ImageConstant.imgSignal,
                height: 11.v,
                width: 12.h,
                margin: EdgeInsets.only(bottom: 2.v)),
            Text(fortyTwoText,
                style: theme.textTheme.labelMedium!
                    .copyWith(color: appTheme.blueGray90001))
          ])),
      Padding(
          padding: EdgeInsets.only(left: 16.h),
          child: Text(separatorText,
              style: CustomTextStyles.titleSmallBlack900
                  .copyWith(color: appTheme.black900))),
      Padding(
          padding: EdgeInsets.only(left: 16.h, top: 3.v),
          child: Text(stdCounterText,
              style: theme.textTheme.labelMedium!
                  .copyWith(color: appTheme.blueGray90001)))
    ]);
  }

  Widget _buildGraphicDesign(BuildContext context, {required String text}) {
    return SizedBox(
        width: 245.h,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
              padding: EdgeInsets.only(bottom: 1.v),
              child: Text(text,
                  style: CustomTextStyles.labelLargeMulishOrangeA700
                      .copyWith(color: appTheme.orangeA700))),
          CustomImageView(
              imagePath: ImageConstant.imgBookmark, height: 18.v, width: 14.h)
        ]));
  }
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: CourseWidget(),
    ),
  ));
}
