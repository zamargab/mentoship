import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorship/Config/config.dart';
import 'package:mentorship/DialogBox/errorDialog.dart';
import 'package:mentorship/DialogBox/loadingDialog.dart';
import 'package:mentorship/Home/home.dart';
import 'package:mentorship/Widgets/customTextFields.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final TextEditingController _cPasswordTextEditingController =
      TextEditingController();

  final TextEditingController _phoneNumberTextEditingController =
      TextEditingController();

  final TextEditingController _genderTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = "";
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Color(0xFF1d354f),
      ),
      body: Container(
        color: Color(0xFFfafafa),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: new AssetImage('images/top2.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(100)),
                ),
                width: _screenWidth,
                height: _screenheight * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(_screenheight * 0.1),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.person,
                            color: Color(0xFF1d354f),
                            size: 80.0,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 19.0),
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 13.0, right: 13.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 10.0),
                    InkWell(
                      onTap: () => _selectAndPickImage(),
                      child: CircleAvatar(
                        radius: _screenWidth * 0.15,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            _imageFile == null ? null : FileImage(_imageFile),
                        child: _imageFile == null
                            ? Icon(
                                Icons.add_a_photo_sharp,
                                size: _screenWidth * 0.15,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _nameTextEditingController,
                            data: Icons.person,
                            hintText: "Name",
                            isObsecure: false,
                          ),
                          CustomTextField(
                            controller: _emailTextEditingController,
                            data: Icons.email,
                            hintText: "Email",
                            isObsecure: false,
                          ),
                          CustomTextField(
                            controller: _passwordTextEditingController,
                            data: Icons.keyboard_arrow_down,
                            hintText: "Password",
                            isObsecure: true,
                          ),
                          CustomTextField(
                            controller: _cPasswordTextEditingController,
                            data: Icons.keyboard,
                            hintText: "Confirm password",
                            isObsecure: true,
                          ),
                          CustomTextField(
                            controller: _phoneNumberTextEditingController,
                            data: Icons.phone,
                            hintText: "Phone Number",
                            isObsecure: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      onPressed: () {
                        uploadAndsaveImage();
                      },
                      color: Color(0xFF1d354f),
                      child: Text(
                        "Signup",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      padding: EdgeInsets.only(
                          left: _screenWidth * 0.35,
                          right: _screenWidth * 0.35,
                          top: 20.0,
                          bottom: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 4.0,
                      width: _screenWidth * 0.8,
                      color: Color(0xFF1d354f),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    Fluttertoast.showToast(msg: "Image Selected successfully");
  }

  Future<void> uploadAndsaveImage() async {
    if (_imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: "Please Select an image",
            );
          });
    } else {
      _passwordTextEditingController.text ==
              _cPasswordTextEditingController.text
          ? _emailTextEditingController.text.isNotEmpty &&
                  _passwordTextEditingController.text.isNotEmpty &&
                  _cPasswordTextEditingController.text.isNotEmpty &&
                  _nameTextEditingController.text.isNotEmpty &&
                  _phoneNumberTextEditingController.text.isNotEmpty
              ? uploadToStorage()
              : displayDialog("Please Complete form Appropriately")
          : displayDialog("Password do not match");
    }
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Authenticating, Please wait.....",
          );
        });

    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(imageFileName);

    StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);

    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      userImageUrl = urlImage;

      _registerUser();
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {
    FirebaseUser firebaseUser;
    await _auth
        .createUserWithEmailAndPassword(
            email: _emailTextEditingController.text.trim(),
            password: _passwordTextEditingController.text.trim())
        .then((auth) {
      firebaseUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });

    if (firebaseUser != null) {
      saveUserInfoToFirestore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => Home());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future saveUserInfoToFirestore(FirebaseUser fUser) async {
    var document =
        await Firestore.instance.collection('batch').document('sweet').get();

    final QuerySnapshot qSnap = await Firestore.instance
        .collection('users')
        .where("batch", isEqualTo: document["bName"])
        .getDocuments();
    var number = qSnap.documents.length;
    var numberPlus = number + 1;
    var convertedNumber = numberPlus.toString();

    Firestore.instance.collection("users").document(fUser.uid).setData({
      "uid": fUser.uid,
      "email": fUser.email,
      "displayName": _nameTextEditingController.text.trim(),
      "phoneNumber": _phoneNumberTextEditingController.text.trim(),
      "url": userImageUrl,
      "batch": document["bName"],
      "batchNumber": "MCB${document["bName"]}/$convertedNumber"
    });

    await MentorshipApp.sharedPreferences.setString("uid", fUser.uid);
    await MentorshipApp.sharedPreferences
        .setString(MentorshipApp.userEmail, fUser.email);
    await MentorshipApp.sharedPreferences
        .setString(MentorshipApp.userName, _nameTextEditingController.text);
    await MentorshipApp.sharedPreferences
        .setString(MentorshipApp.userAvatarUrl, userImageUrl);
    await MentorshipApp.sharedPreferences.setString(
        MentorshipApp.phoneNumber, _phoneNumberTextEditingController.text);

    await MentorshipApp.sharedPreferences.setString(
        MentorshipApp.batchNumber, "MCB${document["bName"]}/$convertedNumber");

    await MentorshipApp.sharedPreferences
        .setString(MentorshipApp.batchNo, document["bName"]);
  }
}
