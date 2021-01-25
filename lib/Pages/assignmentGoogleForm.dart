import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mentorship/Authentication/login.dart';
import 'package:mentorship/Config/config.dart';
import 'package:mentorship/Widgets/myDrawer.dart';

class GoogleForm extends StatefulWidget {
  GoogleForm(this.submitUrl, this.responseUrl, this.docID, {Key key})
      : super(key: key);
  final String submitUrl;
  final String responseUrl;
  final String docID;

  @override
  _GoogleFormState createState() => _GoogleFormState();
}

class _GoogleFormState extends State<GoogleForm> {
  InAppWebViewController controller;
  String url = "";
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
      body: SafeArea(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : Container(),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.all(10),
              child: InAppWebView(
                initialUrl: widget.submitUrl,
                initialHeaders: {},
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(debuggingEnabled: true)),
                onWebViewCreated: (webViewController) =>
                    controller = webViewController,
                onLoadStart: (controller, url) {
                  setState(() {
                    this.url = url;
                  });

                  if (url.endsWith('/formResponse')) {
                    updateStatus();
                  }
                },
                onLoadStop: (controller, url) {
                  setState(() {
                    this.url = url;
                  });
                },
                onProgressChanged: (controller, progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ))
          ],
        ),
      )),
    );
  }

  Future updateStatus() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    Firestore.instance
        .collection("users")
        .document(
            MentorshipApp.sharedPreferences.getString(MentorshipApp.userUID))
        .collection("assignmentResponses")
        .document(widget.docID)
        .setData({
      "status": "Submitted",
      "user": user.uid,
      "assignmentID": widget.docID,
    });

    Fluttertoast.showToast(msg: "Submitted Sucessfully");
  }
}
