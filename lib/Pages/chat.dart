import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentorship/Authentication/login.dart';
import 'package:mentorship/Config/app_onstant.dart';
import 'package:mentorship/Config/config.dart';
import 'package:mentorship/Models/chatModel.dart';
import 'package:mentorship/Widgets/myDrawer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Chat extends StatefulWidget {
  Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _messageTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ItemScrollController _scrollController = ItemScrollController();

  _buildMessageComposer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      margin: EdgeInsets.all(10),
      height: 60.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: TextField(
                  controller: _messageTextEditingController,
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
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Color(0xFF1d354f),
            onPressed: () => handleSubmitted(),
          ),
        ],
      ),
    );
  }

  Future handleSubmitted() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;
    FirebaseUser user = await _auth.currentUser();
    var document =
        await Firestore.instance.collection('users').document(user.uid).get();

    if (_messageTextEditingController.text.isNotEmpty) {
      Firestore.instance.collection("chat").document().setData({
        "author": document["displayName"],
        "userID": document["uid"],
        "message": _messageTextEditingController.text.trim(),
        "time": DateTime.now(),
      });
      _messageTextEditingController.clear();
    }
  }

  Widget _buildMessage(String message, String author, bool isMe) {
    final Widget msg = Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        margin: isMe
            ? EdgeInsets.only(
                top: 2.0,
                bottom: 2.0,
                left: 80.0,
              )
            : EdgeInsets.only(
                top: 2.0,
                bottom: 2.0,
              ),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: isMe
              ? AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR_ACTION)
              : AppConstants.hexToColor(
                  AppConstants.APP_BACKGROUND_COLOR_WHITE),
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                ClipOval(
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
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 7),
                Text(
                  MentorshipApp.sharedPreferences
                      .getString(MentorshipApp.userName),
                  style: TextStyle(color: isMe ? Colors.white : Colors.black),
                )
              ],
            ),
            SizedBox(height: 5),
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white60 : Colors.blueGrey,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.0),
            Row(
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '9pm',
                  style: TextStyle(
                    color: isMe ? Colors.white60 : Colors.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return Row(
      children: <Widget>[msg],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
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
        color: Color(0xFFdcdcdc),
        child: Column(
          children: [
            Flexible(
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('chat')
                      .orderBy("time")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot _card =
                            snapshot.data.documents[index];

                        final bool isMe = MentorshipApp.sharedPreferences
                                .getString(MentorshipApp.userUID) ==
                            _card['userID'];
                        _scrollController.scrollTo(
                            index: 7, duration: Duration(seconds: 1));
                        return _buildMessage(
                            _card['message'], _card['author'], isMe);
                      },
                    );
                  }),
            ),
            _buildMessageComposer()
          ],
        ),
      ),
    );
  }
}
