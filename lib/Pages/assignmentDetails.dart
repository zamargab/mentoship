import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentorship/Admin/createAssignment.dart';
import 'package:mentorship/Authentication/login.dart';
import 'package:mentorship/Config/config.dart';
import 'package:mentorship/Pages/assignmentGoogleForm.dart';
import 'package:mentorship/Widgets/myDrawer.dart';

class AssignmentDetails extends StatefulWidget {
  AssignmentDetails(this.docID, {Key key}) : super(key: key);
  final String docID;

  @override
  _AssignmentDetailsState createState() => _AssignmentDetailsState();
}

class _AssignmentDetailsState extends State<AssignmentDetails> {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    var _screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Universal"),
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
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFF1d354f),
                border: Border.all(color: Colors.white, width: 5),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('assignments')
                    .where(FieldPath.documentId, isEqualTo: widget.docID)
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

                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Table(
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
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
                                              "Issue Date: 9th Jan ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
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
                                              "Submission: 9PM",
                                              style: TextStyle(
                                                  color: Colors.white,
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
                                          child:
                                              FutureBuilder<DocumentSnapshot>(
                                            future: Firestore.instance
                                                .collection("users")
                                                .document(MentorshipApp
                                                    .sharedPreferences
                                                    .getString(
                                                        MentorshipApp.userUID))
                                                .collection(
                                                    "assignmentResponses")
                                                .document(widget.docID)
                                                .get(),
                                            builder: (c, snapshot) {
                                              if (!snapshot.hasData ||
                                                  snapshot.data.data == null)
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.redAccent,
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 3),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 2, 10, 2),
                                                  child: Text("Unsubmitted"),
                                                ); //CIRCULAR INDICATOR
                                              else {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors
                                                          .lightGreenAccent,
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 3),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20))),
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 2, 10, 2),
                                                  child: Text(snapshot
                                                      .data.data["status"]),
                                                );
                                              }
                                            },
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
                                            "Meeting ID: ",
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
                            Divider(color: Colors.white),
                            SizedBox(height: 20),
                            Text(
                              _card["assignment"],
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: _screen_width * 0.0),
                              child: Container(
                                child: PopupMenuButton(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.white, width: 5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 10),
                                      child: Text("Submit")),
                                  itemBuilder: (BuildContext bc) => [
                                    PopupMenuItem(
                                      child: Text("Submit via Google form"),
                                      value: 1,
                                    ),
                                    PopupMenuItem(
                                      child: Text("Submit via app"),
                                      value: 2,
                                    ),
                                  ],
                                  onSelected: (int menu) {
                                    if (menu == 1) {
                                      navigatorKey.currentState.push(
                                        MaterialPageRoute(
                                          builder: (context) => GoogleForm(
                                              _card["submitUrl"],
                                              _card["responseUrl"],
                                              widget.docID),
                                        ),
                                      );
                                    } else if (menu == 2) {
                                      navigatorKey.currentState.push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CreateAssignment(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
          ),
        ),
      ),
    );
  }

  Future<Text> getstatus() async {
    var document = await Firestore.instance
        .collection("users")
        .document(
            MentorshipApp.sharedPreferences.getString(MentorshipApp.userUID))
        .collection("assignmentResponses")
        .document(
            MentorshipApp.sharedPreferences.getString(MentorshipApp.userUID))
        .get();

    return Text(document["status"]);
  }
}
