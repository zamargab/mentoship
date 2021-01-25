import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentorship/Authentication/login.dart';
import 'package:mentorship/Config/config.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
            color: Colors.black.withOpacity(0.7),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  elevation: 8.0,
                  child: Container(
                    height: 160.0,
                    width: 160.0,
                    child: ClipOval(
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
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  MentorshipApp.sharedPreferences
                      .getString(MentorshipApp.userName),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: "Signatra",
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1.0,
            color: Colors.grey,
            thickness: 1.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 1.0),
            color: Colors.black.withOpacity(0.7),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                Divider(
                  height: 1.0,
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.reorder,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Chat",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                Divider(
                  height: 1.0,
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.post_add_sharp,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Assignments",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                Divider(
                  height: 1.0,
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.meeting_room,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Zoom Meetings",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                Divider(
                  height: 1.0,
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.speaker,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Announcements",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                Divider(
                  height: 1.0,
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    MentorshipApp.auth.signOut().then((c) {
                      Route route = MaterialPageRoute(builder: (c) => Login());
                      Navigator.push(context, route);
                    });
                  },
                ),
                Divider(
                  height: 1.0,
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: Text(
                    "LogOut",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    MentorshipApp.auth.signOut().then((c) {
                      Route route = MaterialPageRoute(builder: (c) => Login());
                      Navigator.push(context, route);
                    });
                  },
                ),
                Divider(
                  height: 1.0,
                  color: Colors.grey,
                  thickness: 1.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
