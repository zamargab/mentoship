import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentorship/Authentication/login.dart';
import 'package:mentorship/DialogBox/errorDialog.dart';
import 'package:mentorship/Widgets/customTextFields.dart';
import 'package:mentorship/Widgets/myDrawer.dart';

class CreateZoom extends StatefulWidget {
  CreateZoom({Key key}) : super(key: key);

  @override
  _CreateZoomState createState() => _CreateZoomState();
}

class _CreateZoomState extends State<CreateZoom> {
  final TextEditingController _meetindIDTextEditingController =
      TextEditingController();
  final TextEditingController _topicTextEditingController =
      TextEditingController();

  final TextEditingController _urlTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
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
      body: Container(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _topicTextEditingController,
                    data: Icons.topic,
                    hintText: "Topic",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _meetindIDTextEditingController,
                    data: Icons.account_box,
                    hintText: "Meeting ID",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _urlTextEditingController,
                    data: Icons.forward,
                    hintText: "Meeting Url link",
                    isObsecure: false,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () => handleSubmitted(),
              color: Color(0xFF1d354f),
              child: Text(
                "create",
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
          ],
        ),
      ),
    );
  }

  handleSubmitted() {
    if (_meetindIDTextEditingController.text.isNotEmpty &&
        _topicTextEditingController.text.isNotEmpty &&
        _urlTextEditingController.text.isNotEmpty) {
      Firestore.instance.collection("zoom").document().setData({
        "topic": _topicTextEditingController.text,
        "meetingID": _meetindIDTextEditingController.text,
        "url": _urlTextEditingController.text,
        "time": DateTime.now(),
      });
    }
  }
}
