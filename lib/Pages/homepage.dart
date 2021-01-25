import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mentorship/Authentication/login.dart';
import 'package:mentorship/Widgets/myDrawer.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
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
          color: Color(0xFFdcdcdc),
          child: Column(
            children: [
              Container(
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: new AssetImage('images/barley.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 100.0),
                  ),
                ),
                width: _screenWidth,
                height: _screenHeight * 0.4,
                child: Center(
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Signatra",
                        fontSize: 80,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              "We're glad you're here!",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.",
                          style: TextStyle(color: Colors.black54, fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 5),
                      Table(
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      _screenWidth * 0.05,
                                      20,
                                      _screenWidth * 0.05,
                                      20),
                                  decoration: new BoxDecoration(
                                      border: new Border.all(
                                          color: Colors
                                              .transparent), //color is transparent so that it does not blend with the actual color specified
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(5.0)),
                                      color: Color(0xFF1d354f).withOpacity(
                                          0.7) // Specifies the background color and the opacity
                                      ),
                                  child: Text(
                                    "Facebook",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      _screenWidth * 0.05,
                                      20,
                                      _screenWidth * 0.05,
                                      20),
                                  decoration: new BoxDecoration(
                                      border: new Border.all(
                                          color: Colors
                                              .transparent), //color is transparent so that it does not blend with the actual color specified
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(5.0)),
                                      color: Color(0xFF1d354f).withOpacity(
                                          0.7) // Specifies the background color and the opacity
                                      ),
                                  child: Text(
                                    "Instagram",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      _screenWidth * 0.05,
                                      20,
                                      _screenWidth * 0.05,
                                      20),
                                  decoration: new BoxDecoration(
                                      border: new Border.all(
                                          color: Colors
                                              .transparent), //color is transparent so that it does not blend with the actual color specified
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(5.0)),
                                      color: Color(0xFF1d354f).withOpacity(
                                          0.7) // Specifies the background color and the opacity
                                      ),
                                  child: Text(
                                    "Twitter",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      _screenWidth * 0.05,
                                      20,
                                      _screenWidth * 0.05,
                                      20),
                                  decoration: new BoxDecoration(
                                      border: new Border.all(
                                          color: Colors
                                              .transparent), //color is transparent so that it does not blend with the actual color specified
                                      borderRadius: const BorderRadius.all(
                                          const Radius.circular(5.0)),
                                      color: Color(0xFF1d354f).withOpacity(
                                          0.7) // Specifies the background color and the opacity
                                      ),
                                  child: Text(
                                    "Telegram",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
