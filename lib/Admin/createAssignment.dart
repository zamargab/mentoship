import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentorship/Authentication/login.dart';
import 'package:mentorship/DialogBox/errorDialog.dart';
import 'package:mentorship/Widgets/customTextFields.dart';
import 'package:mentorship/Widgets/myDrawer.dart';

class CreateAssignment extends StatefulWidget {
  CreateAssignment({Key key}) : super(key: key);

  @override
  _CreateAssignmentState createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  final TextEditingController _assignmentTextEditingController =
      TextEditingController();

  final TextEditingController _urlTextEditingController =
      TextEditingController();

  final TextEditingController _weekTextEditingController =
      TextEditingController();

  final TextEditingController _responseTextEditingController =
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextField(
                      controller: _assignmentTextEditingController,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration.collapsed(
                        border: InputBorder.none,
                        hintText: 'Type your message...',
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                    CustomTextField(
                      controller: _urlTextEditingController,
                      data: Icons.account_box,
                      hintText: "Submission url",
                      isObsecure: false,
                    ),
                    CustomTextField(
                      controller: _weekTextEditingController,
                      data: Icons.account_box,
                      hintText: "Week",
                      isObsecure: false,
                    ),
                    CustomTextField(
                      controller: _responseTextEditingController,
                      data: Icons.account_box,
                      hintText: "response url",
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
      ),
    );
  }

  handleSubmitted() {
    if (_assignmentTextEditingController.text.isNotEmpty &&
        _urlTextEditingController.text.isNotEmpty &&
        _responseTextEditingController.text.isNotEmpty) {
      Firestore.instance.collection("assignments").document().setData({
        "assignment": _assignmentTextEditingController.text,
        "submitUrl": _urlTextEditingController.text,
        "responseUrl": _responseTextEditingController.text,
        "week": _weekTextEditingController.text,
        "status": "Unsubmitted",
        "time": DateTime.now(),
      });
    }
  }
}
