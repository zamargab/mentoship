import 'package:flutter/material.dart';

class Announcements extends StatefulWidget {
  Announcements({Key key}) : super(key: key);

  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Announcement page"));
  }
}
