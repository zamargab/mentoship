import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentorship/Admin/createAssignment.dart';
import 'package:mentorship/Authentication/login.dart';
import 'package:mentorship/Widgets/menuitem.dart';
import 'package:mentorship/Widgets/myDrawer.dart';

class Assignemnts extends StatefulWidget {
  Assignemnts({Key key}) : super(key: key);

  @override
  _AssignemntsState createState() => _AssignemntsState();
}

class _AssignemntsState extends State<Assignemnts> {
  InAppWebViewController controller;
  String url =
      "https://docs.google.com/forms/d/e/1FAIpQLScZ4ym9bUzV915L-KIt5XPI-HU-2jERwIuUCKfF4mPUb3ngmg/viewform?usp=sf_link";
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('assignments')
                .orderBy("time")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return GridView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot _card = snapshot.data.documents[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF315883),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
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
                                        itemBuilder: (BuildContext context) {
                                          return menuitems
                                              .map((MenuItem menuitem) {
                                            return PopupMenuItem(
                                                child: ListTile(
                                              title: Text(menuitem.menuVal),
                                            ));
                                          }).toList();
                                        }),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _card['week'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
              );
            }),
      ),
    );
  }
}
