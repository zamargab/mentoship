import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentorship/Authentication/login.dart';
import 'package:mentorship/Config/config.dart';
import 'package:mentorship/Widgets/myDrawer.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future getImageUrl() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    var document =
        await Firestore.instance.collection('users').document(user.uid).get();

    return document["batchNumber"];
  }

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Color(0xFF1d354f),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Route route = MaterialPageRoute(builder: (c) => Login());
              Navigator.push(context, route);
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF1d354f),
          child: Column(
            children: [
              Container(
                height: _screenHeight * 0.3,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 160.0,
                    width: 160.0,
                    child: ClipOval(
                      child: Image.network(
                        MentorshipApp.sharedPreferences
                            .getString(MentorshipApp.userAvatarUrl),
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          );
                        },
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Container(
                  width: _screenWidth,
                  decoration: new BoxDecoration(
                    color: Color(0xFFdcdcdc),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 35, 20, 20),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Color(0xFF1d354f),
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Username",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 5, 10),
                                  child: Text(
                                    MentorshipApp.sharedPreferences
                                        .getString(MentorshipApp.userName)
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontFamily: "Signatra"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: Color(0xFF1d354f),
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 5, 10),
                                  child: Text(
                                    MentorshipApp.sharedPreferences
                                        .getString(MentorshipApp.userEmail)
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontFamily: "Signatra"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Color(0xFF1d354f),
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Batch Number",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 5, 10),
                                  child: Text(
                                    MentorshipApp.sharedPreferences
                                        .getString(MentorshipApp.batchNumber)
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontFamily: "Signatra"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Color(0xFF1d354f),
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Phone  Number",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 5, 10),
                                  child: Text(
                                    MentorshipApp.sharedPreferences
                                        .getString(MentorshipApp.phoneNumber)
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontFamily: "Signatra"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.post_add),
        backgroundColor: Color(0xFF1d354f),
      ),
    );
  }
}
