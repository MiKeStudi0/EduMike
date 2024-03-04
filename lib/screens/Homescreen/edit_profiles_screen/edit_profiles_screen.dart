import 'dart:typed_data';
import 'package:edumike/screens/loginscreen/fill_your_profile_screen.dart';
import 'package:edumike/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:edumike/core/app_export.dart';
import 'package:edumike/widgets/app_bar/appbar_leading_image.dart';
import 'package:edumike/widgets/app_bar/appbar_title.dart';
import 'package:edumike/widgets/custom_icon_button.dart';
import 'package:edumike/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EditProfilesScreen());
}

Future<String?> uploadImageToFirebaseStorage(String imageName, Uint8List file) async {
  try {
    // Create a Reference to the image file location in Firebase Storage
    Reference storageReference = FirebaseStorage.instance.ref().child(imageName);

    // Upload the image file to Firebase Storage
    UploadTask uploadTask = storageReference.putData(file);

    // Await for the upload to complete
    await uploadTask.whenComplete(() => null);

    // Get the download URL of the uploaded image
    String imageUrl = await storageReference.getDownloadURL();

    // Return the download URL of the uploaded image
    return imageUrl;
  } catch (error) {
    // Handle any errors that occur during the upload process
    print("Error uploading image: $error");
    return null;
  }
}


 
// ignore_for_file: must_be_immutable
class EditProfilesScreen extends StatefulWidget {
  EditProfilesScreen({Key? key}) : super(key: key);

  @override
  State<EditProfilesScreen> createState() => _FillYourProfileScreenState();
}

class _FillYourProfileScreenState extends State<EditProfilesScreen> {
Uint8List? _image;

void selectImage(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Select Image From"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              getImage(ImageSource.camera);
            },
            child: Text("Camera"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              getImage(ImageSource.gallery);
            },
            child: Text("Gallery"),
          ),
        ],
      );
    },
  );
}

Future<void> getImage(ImageSource source) async {
  Uint8List? img = await pickImage(source);
  if (img != null) {
    setState(() {
      _image = img;
    });
    String? imageUrl = await uploadImageToFirebaseStorage("new_image.jpg", _image!);
    if (imageUrl != null) {
      await updateUserData(imageUrl); // Update user data with the image URL
      print('Image uploaded. URL: $imageUrl');
    } else {
      // Error uploading image
      print('Error uploading image to Firebase Storage');
    }
  }
}




// Function to pick an image
Future<Uint8List?> pickImage(ImageSource source) async {
  XFile? pickedFile = await ImagePicker().pickImage(source: source);
  if (pickedFile != null) {
    // Read the picked file and return its bytes
    return await pickedFile.readAsBytes();
  } else {
    // User canceled the picker
    return null;
  }
}


  TextEditingController fullNameEditTextController = TextEditingController();
  late final String gendervalue;
  // DateTime _picked=DateTime.now();

  FocusNode emailFocusNode = FocusNode();

  FocusNode dateofbirthFocusNode = FocusNode();

  FocusNode fullnameFocusNode = FocusNode();

  FocusNode nicknameFocusNode = FocusNode();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  TextEditingController emailController = TextEditingController();

    TextEditingController genderController = TextEditingController();
      TextEditingController phoneNumberController = TextEditingController();

      Future<void> _selectdate() async {
    DateTime? _picked = await showDatePicker(
        context:context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2500));
    if (_picked != null) {
      setState(() {
        dateOfBirthController.text =
            DateFormat('yyyy-MM-dd').format(_picked);
      });
    }
  }

//   // Retrieve user data including profile image
// Future<void> getUserData() async {
//   User? user = FirebaseAuth.instance.currentUser;
//   if (user == null) {
//     throw Exception('User not authenticated');
//   }

//   String userId = user.uid;

//   CollectionReference userCollection =
//       FirebaseFirestore.instance.collection('users');

//   DocumentSnapshot<Map<String, dynamic>> snapshot =
//       await userCollection.doc(userId).get();

//   if (snapshot.exists) {
//     Map<String, dynamic> userData = snapshot.data()!;
    
//     // Get profile image base64 string from user data
//     String? base64Image = userData['profileImage'];

//     // Decode base64 string to bytes
//     if (base64Image != null) {
//       Uint8List imageBytes = base64Decode(base64Image);
//       // Now you have the image bytes, you can display it using MemoryImage or FileImage
//       setState(() {
//         _image = imageBytes;
//       });
//     }
//   }
// }

// Call getUserData() to retrieve user data including profile image
// // This can be done in initState or wherever you want to fetch the data
// @override
// void initState() {
//   super.initState();
//   getUserData();
// }


 Future<void> updateUserData(String imageUrl) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('User not authenticated');
  }

  String userId = user.uid;

  // Replace 'users' with your Firestore collection name
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Replace the field names and values as per your data structure
  Map<String, dynamic> userData = {
    'fullname': fullNameController.text,
    'nickname': nameController.text,
    'dateofbirth': dateOfBirthController.text,
    'email': emailController.text,
    'gender': genderController.text,
    'phone': phoneNumberController.text,
    'imageUrl': imageUrl, // Add the imageUrl to userData
  };

  // Update user data in Firestore
  await userCollection.doc(userId).set(userData);
}


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: Container(
                          color: appTheme.blue50,
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 34.h, vertical: 29.v),
                            child: Column(children: [
                              SizedBox(
                    height: 94.v,
                    width: 93.h,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        _image!=null?
                       Container(
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: appTheme.teal700, // Set border color here
      width: 4, // Set border width here
    ),
  ),
  child: CircleAvatar(
    radius: 64,
   backgroundImage: MemoryImage(_image!),
    // Add child here if needed
  ),
):
                        
   Container(
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: appTheme.teal700, // Set border color here
      width: 4, // Set border width here
    ),
  ),
  child: CircleAvatar(
    radius: 64,
    backgroundColor: Colors.white,
    // Add child here if needed
  ),
),
  Padding(
    padding: EdgeInsets.only(right: 9.h),
    child: CustomIconButton(
      height: 33.adaptSize,
      width: 33.adaptSize,
      padding: EdgeInsets.all(7.h),
      decoration: IconButtonStyleHelper.outlineTeal,
      alignment: Alignment.bottomRight,
      child: Container(
        child: GestureDetector(
          child: CustomImageView(
            imagePath: ImageConstant.imgTelevisionTeal700,
            onTap: () {
              selectImage(context);
            },
          ),
        ),
      ),
    ),
  ),
]

                    ),
                  ),
                              SizedBox(height: 30.v),
                              _buildFullNameEditText(context),
                              SizedBox(height: 20.v),
                              _buildNameEditText(context),
                              SizedBox(height: 20.v),
                              _buildDateOfBirthEditText(context),
                              SizedBox(height: 20.v),
                              _buildEmailEditText(context),
                              SizedBox(height: 20.v),
                              _buildPhoneNumber(context),
                              SizedBox(height: 20.v),
                              _buildgender(context),
                              SizedBox(height: 20.v),
                              _buildUpdateButton(),
                              SizedBox(height: 5.v)
                            ])))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
 backgroundColor: appTheme.blue50,    leadingWidth: 61.h,
    leading: AppbarLeadingImage(
      imagePath: ImageConstant.imgArrowDown,
      margin: EdgeInsets.only(left: 35.h, top: 18.v, bottom: 17.v),
    ),
    title: AppbarTitle(
      text: "Edit Your Profile",
      margin: EdgeInsets.only(left: 12.h),
    ),
  );
}


  /// Section Widget
  Widget _buildFullNameEditText(BuildContext context) {
  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDocument(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the data to load, show a loading indicator
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If an error occurs while fetching the data, show the error message
        return Text('Error: ${snapshot.error}');
      } else {
        // If the data is successfully fetched, extract the full name
        String? fullName = snapshot.data?.data()?['fullname'];

        if (fullName == null) {
          // If full name is null, handle the case accordingly
          return Text('Full name not found');
        }

        // Set the initial value of the fullNameController
        fullNameController.text = fullName;

        // Return the CustomTextFormField with onChanged callback to update the controller
        return Container(
          decoration: AppDecoration.outlineBlack
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: CustomTextFormField(
             prefix: Container(
              margin: EdgeInsets.fromLTRB(21.h, 20.v, 8.h, 20.v),
              child: Icon(Icons.person, color: appTheme.blueGray900, size: 20.v,)
            ),
            controller: fullNameController,
            hintText: "Full Name",
            contentPadding: EdgeInsets.only(left: 16.0,top: 35), // Adjust the left padding as needed
          ),
        );
      }
    },
  );
}


  /// Section Widget
  Widget _buildNameEditText(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDocument(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the data to load, show a loading indicator
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If an error occurs while fetching the data, show the error message
        return Text('Error: ${snapshot.error}');
      } else {
        // If the data is successfully fetched, extract the full name
        String? nickName = snapshot.data?.data()?['nickname'];

        if (nickName == null) {
          // If full name is null, handle the case accordingly
          return Text('nick name not found');
        }

        // Create a TextEditingController and set its initial value to the full name
        nameController.text = nickName;

        // Return the CustomTextFormField with the initialized controller
        return Container(
          decoration: AppDecoration.outlineBlack
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: CustomTextFormField(
            prefix: Container(
              margin: EdgeInsets.fromLTRB(21.h, 20.v, 8.h, 20.v),
              child: Icon(Icons.call, color: appTheme.blueGray900, size: 20.v,)
            ),
            
            controller: nameController,
            hintText: "nick Name",
            contentPadding: EdgeInsets.only(left: 16.0,top: 35), 
          ),
        );
      }
    },
  );
}

  /// Section Widget
  Widget _buildDateOfBirthEditText(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDocument(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the data to load, show a loading indicator
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If an error occurs while fetching the data, show the error message
        return Text('Error: ${snapshot.error}');
      } else {
        // If the data is successfully fetched, extract the full name
        String? dob = snapshot.data?.data()?['dateofbirth'];

        if (dob == null) {
          // If full name is null, handle the case accordingly
          return Text('dob not found');
        }

        // Create a TextEditingController and set its initial value to the full name
        dateOfBirthController.text = dob;

        // Return the CustomTextFormField with the initialized controller
        return Container(
          decoration: AppDecoration.outlineBlack
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: CustomTextFormField(
            controller: dateOfBirthController,
            hintText: " dateofbirth",
            contentPadding: EdgeInsets.only(left: 16.0,top: 35), 
            prefix: Container(
            margin: EdgeInsets.fromLTRB(21.h, 20.v, 8.h, 20.v),
            child: GestureDetector(
              child: Icon(Icons.calendar_month, color: appTheme.blueGray900, size: 20.v,),
              onTap: () => _selectdate(),
            )),
          ),
        );
      }
    },
  );
}

  /// Section Widget
  Widget _buildEmailEditText(BuildContext context) {
   return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDocument(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the data to load, show a loading indicator
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If an error occurs while fetching the data, show the error message
        return Text('Error: ${snapshot.error}');
      } else {
        // If the data is successfully fetched, extract the full name
        String? email = snapshot.data?.data()?['email'];

        if (email == null) {
          // If full name is null, handle the case accordingly
          return Text('email not found');
        }

        // Create a TextEditingController and set its initial value to the full name
        emailController.text = email;

        // Return the CustomTextFormField with the initialized controller
        return Container(
          decoration: AppDecoration.outlineBlack
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: CustomTextFormField(
            prefix: Container(
              margin: EdgeInsets.fromLTRB(21.h, 20.v, 8.h, 20.v),
              child: Icon(Icons.email, color: appTheme.blueGray900, size: 20.v,)
            ),
            controller: emailController,
            hintText: " email",
            contentPadding: EdgeInsets.only(left: 16.0,top: 35), 
          ),
        );
      }
    },
  );
}

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
   return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDocument(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the data to load, show a loading indicator
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If an error occurs while fetching the data, show the error message
        return Text('Error: ${snapshot.error}');
      } else {
        // If the data is successfully fetched, extract the full name
        String? phone = snapshot.data?.data()?['phone'];

        if (phone == null) {
          // If full name is null, handle the case accordingly
          return Text('phone not found');
        }

        // Create a TextEditingController and set its initial value to the full name
        phoneNumberController.text = phone;

        // Return the CustomTextFormField with the initialized controller
        return Container(
          decoration: AppDecoration.outlineBlack
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: CustomTextFormField(
            prefix: Container(
              margin: EdgeInsets.fromLTRB(21.h, 20.v, 8.h, 20.v),
              child: Icon(Icons.phone, color: appTheme.blueGray900, size: 20.v,)
            ),
            controller: phoneNumberController,
            hintText: " phone",
            contentPadding: EdgeInsets.only(left: 16.0,top: 35),
          ),
        );
      }
    },
  );
}

Widget _buildgender(BuildContext context) {
  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDocument(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While waiting for the data to load, show a loading indicator
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // If an error occurs while fetching the data, show the error message
        return Text('Error: ${snapshot.error}');
      } else {
        // If the data is successfully fetched, extract the full name
        String? gender= snapshot.data?.data()?['gender'];

        if (gender == null) {
          // If full name is null, handle the case accordingly
          return Text('gender not found');
        }

        // Create a TextEditingController and set its initial value to the full name
        genderController.text = gender;

        // Return the CustomTextFormField with the initialized controller
        return Container(
          decoration: AppDecoration.outlineBlack
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
          child: CustomTextFormField(
            prefix: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(Icons.person_2_rounded, color: appTheme.blueGray900, size: 20.v,),
            ),
            controller: genderController,
            hintText: "gender ",
            contentPadding: EdgeInsets.only(left: 16.0,top: 35),
          ),
        );
      }
    },
  );
}

  /// Section Widget
  Widget _buildUpdateButton() {
  return CustomElevatedButton(
    text: "Update",
    margin: EdgeInsets.symmetric(horizontal: 5.h),
    rightIcon: Container(
      padding: EdgeInsets.fromLTRB(14.h, 16.v, 12.h, 14.v),
      margin: EdgeInsets.only(left: 30.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(24.h),
      ),
      child: CustomImageView(
        imagePath: ImageConstant.imgArrowrightPrimary17x21,
        height: 17.v,
        width: 21.h,
      ),
    ),
    onPressed: () async {
    },
  );
}


    
  }

