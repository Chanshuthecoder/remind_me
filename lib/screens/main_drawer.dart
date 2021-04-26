import 'package:flutter/material.dart';
import 'package:remind_me/main.dart';
import 'package:remind_me/screens/my_post.dart';
import 'package:remind_me/screens/update_profile.dart';
import 'package:remind_me/util/auth.dart';
import 'package:remind_me/util/user.dart';

class MainDrawer extends StatefulWidget {
  //constructer
  final UserDetails userData;
  MainDrawer({this.userData});

  @override
  _MainDrawerState createState() => _MainDrawerState(userData);
}

class _MainDrawerState extends State<MainDrawer> {
  UserDetails userData;
  _MainDrawerState(this.userData);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                        color: Colors.grey,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 2,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10),
                        )
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage('${userData.uProfilePic}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    "${userData.uName}",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${userData.uEmail}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ListTile(
            leading: Icon(Icons.post_add_rounded),
            onTap: () {
              if (userData.uType != "Student") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyPost(club: userData.uName),
                  ),
                );
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: ListTile(
                          leading: Icon(
                            Icons.dangerous,
                            color: Colors.red,
                            size: 28,
                          ),
                          title: Text("You're not an Organisation"),
                        ),
                      );
                    });
              }
            },
            title: Text(
              "My Posts",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ListTile(
            leading: Icon(Icons.edit),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Updateprofile(userData: userData),
                ),
              );
            },
            title: Text(
              "Update Profile",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            onTap: () {
              logOut().whenComplete(() {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()),
                  ModalRoute.withName('/'),
                );
              });
            },
            title: Text(
              "Log Out",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void removeSession() {}
}
