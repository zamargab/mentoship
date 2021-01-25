import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentorship/Admin/createZoom.dart';
import 'package:mentorship/Authentication/login.dart';
import 'package:mentorship/Widgets/myDrawer.dart';
import 'package:url_launcher/url_launcher.dart';

class Zoom extends StatefulWidget {
  Zoom({Key key}) : super(key: key);

  @override
  _ZoomState createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {
  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Zoom meetings"),
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
      body: Container(
        color: Color(0xFF1d354f),
        child: Container(
          color: Color(0xFFdcdcdc),
          child: Column(
            children: [
              Flexible(
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('zoom')
                        .orderBy("time")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return new ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot _card =
                              snapshot.data.documents[index];

                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: new BoxDecoration(
                                  image: DecorationImage(
                                    image: new AssetImage('images/top2.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  shadowColor: Colors.red,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          _card['topic'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25),
                                        ),
                                        SizedBox(height: 15),
                                        Table(
                                          children: [
                                            TableRow(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.date_range,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 2),
                                                      Container(
                                                        child: Text(
                                                          "Date: 9th Jan ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.lock_clock,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 2),
                                                      Container(
                                                        child: Text(
                                                          "Time: 9PM",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.person,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 2),
                                                    Container(
                                                      child: Text(
                                                        "Attendance: All",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.meeting_room,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 2),
                                                    Container(
                                                      child: Text(
                                                        "Meeting ID: " +
                                                            _card['meetingID'],
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 19),
                                        RaisedButton(
                                          onPressed: () => _openzoom(),
                                          color: Color(0xFF1d354f),
                                          child: Text(
                                            "Connect",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          padding: EdgeInsets.only(
                                              left: _screenWidth * 0.05,
                                              right: _screenWidth * 0.05,
                                              top: 7.0,
                                              bottom: 7.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _openzoom() async {
    const url = 'https://us02web.zoom.us/j/82133380774';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
