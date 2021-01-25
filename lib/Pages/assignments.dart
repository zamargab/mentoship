import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentorship/Admin/createAssignment.dart';
import 'package:mentorship/Authentication/login.dart';
import 'package:mentorship/Pages/assignmentDetails.dart';
import 'package:mentorship/Pages/chat.dart';
import 'package:mentorship/Widgets/menuitem.dart';
import 'package:mentorship/Widgets/myDrawer.dart';

class Assignemnts extends StatefulWidget {
  Assignemnts({Key key}) : super(key: key);

  @override
  _AssignemntsState createState() => _AssignemntsState();
}

class _AssignemntsState extends State<Assignemnts> {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Assignments"),
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('assignments')
                  .orderBy("time")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return GridView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot _card =
                        snapshot.data.documents[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 140,
                        decoration: BoxDecoration(
                          color: Color(0xFF315883),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Container(
                          child: Stack(
                            children: [
                              Positioned(
                                right: 0.0,
                                top: 0.0,
                                child: PopupMenuButton(
                                  icon: Icon(
                                    FontAwesomeIcons.ellipsisV,
                                    color: Colors.white,
                                  ),
                                  itemBuilder: (BuildContext bc) => [
                                    PopupMenuItem(
                                      child: Text("View Details"),
                                      value: 1,
                                    ),
                                  ],
                                  onSelected: (int menu) {
                                    if (menu == 1) {
                                      navigatorKey.currentState.push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AssignmentDetails(_card
                                                      .documentID
                                                      .toString())));
                                    }
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 20.0,
                                left: 10.0,
                                child: Text(
                                  _card['week'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                );
              }),
        ),
      ),
    );
  }
}
