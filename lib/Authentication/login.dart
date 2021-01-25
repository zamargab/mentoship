import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentorship/Admin/adminLogin.dart';
import 'package:mentorship/Authentication/register.dart';
import 'package:mentorship/Config/config.dart';
import 'package:mentorship/Config/constants.dart';
import 'package:mentorship/DialogBox/errorDialog.dart';
import 'package:mentorship/DialogBox/loadingDialog.dart';
import 'package:mentorship/Home/home.dart';
import 'package:mentorship/Widgets/customTextFields.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                            Icons.people,
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
                          "Login",
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
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        "Login to your account",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _emailTextEditingController,
                            data: Icons.email,
                            hintText: "Email",
                            isObsecure: false,
                          ),
                          CustomTextField(
                            controller: _passwordTextEditingController,
                            data: Icons.person,
                            hintText: "Password",
                            isObsecure: true,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0, top: 15.0),
                        child: Text(
                          "Forgot password",
                          style: TextStyle(
                            color: Color(0xFF1d354f),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      onPressed: () {
                        _emailTextEditingController.text.isNotEmpty &&
                                _passwordTextEditingController.text.isNotEmpty
                            ? loginUser()
                            : showDialog(
                                context: context,
                                builder: (c) {
                                  return ErrorAlertDialog(
                                    message: "Please Type email and paddword",
                                  );
                                });
                      },
                      color: Color(0xFF1d354f),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      padding: EdgeInsets.only(
                          left: _screenWidth * 0.35,
                          right: _screenWidth * 0.35,
                          top: 20.0,
                          bottom: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        FlatButton(
                          onPressed: () {
                            Route route =
                                MaterialPageRoute(builder: (c) => Register());
                            Navigator.push(context, route);
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Color(0xFF1d354f), fontSize: 18),
                          ),
                          color: Color(0xFFfafafa),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Container(
                      height: 4.0,
                      width: _screenWidth * 0.8,
                      color: Color(0xFF1d354f),
                    ),
                    SizedBox(height: 10.0),
                    FlatButton.icon(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminLoginPage())),
                      icon: (Icon(
                        Icons.nature_people,
                        color: Color(0xFFffa523),
                      )),
                      label: Text(
                        "Admin login",
                        style: TextStyle(
                            color: Color(0xFF1d354f),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void loginUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Authenticating, please wait",
          );
        });
    FirebaseUser firebaseUser;
    await _auth
        .signInWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
        .then((authUser) {
      firebaseUser = authUser.user;
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
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => Home());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future readData(FirebaseUser fUser) async {
    Firestore.instance
        .collection("users")
        .document(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      await MentorshipApp.sharedPreferences
          .setString("uid", dataSnapshot.data[MentorshipApp.userUID]);

      await MentorshipApp.sharedPreferences.setString(
          MentorshipApp.userEmail, dataSnapshot.data[MentorshipApp.userEmail]);

      await MentorshipApp.sharedPreferences
          .setString(MentorshipApp.userName, dataSnapshot.data["displayName"]);

      await MentorshipApp.sharedPreferences.setString(
          MentorshipApp.batchNumber, dataSnapshot.data["batchNumber"]);

      await MentorshipApp.sharedPreferences.setString(
          MentorshipApp.phoneNumber, dataSnapshot.data["phoneNumber"]);

      await MentorshipApp.sharedPreferences.setString(
          MentorshipApp.userAvatarUrl,
          dataSnapshot.data[MentorshipApp.userAvatarUrl]);
    });
  }
}
