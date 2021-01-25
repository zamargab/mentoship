import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mentorship/Authentication/login.dart';
import 'package:mentorship/Pages/Chat.dart';
import 'package:mentorship/Pages/announcements.dart';
import 'package:mentorship/Pages/assignments.dart';
import 'package:mentorship/Pages/homepage.dart';
import 'package:mentorship/Pages/profile.dart';
import 'package:mentorship/Pages/zoom.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;

  final Announcements _announcements = Announcements();
  final Assignemnts _assignemnts = new Assignemnts();
  final Homepage _homepage = new Homepage();
  final Chat _chat = new Chat();
  final Zoom _zoom = new Zoom();

  final Profile _profile = new Profile();

  Widget _showPage = new Homepage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _assignemnts;
        break;

      case 1:
        return _zoom;
        break;
      case 2:
        return _homepage;
        break;

      case 3:
        return _chat;
        break;

      case 4:
        return _profile;
        break;
    }
  }

  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.add, size: 20),
          Icon(Icons.list, size: 20),
          Icon(Icons.home, size: 20),
          Icon(Icons.call_split, size: 20),
          Icon(Icons.perm_identity, size: 20),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Color(0xFFdcdcdc),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (int tappedIndex) {
          setState(() {
            _showPage = _pageChooser(tappedIndex);
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
        color: Color(0xFFdcdcdc),
        child: Container(
          child: _showPage,
        ),
      ),
    );
  }
}
