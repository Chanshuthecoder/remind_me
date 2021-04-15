import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/screens/components/clublist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  // String Feeds;
  String uid = 'nn2l8mO5RcUsIicXZIQjwjmtGiQ2';
  final db = FirebaseFirestore.instance;
  _loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _uid = (prefs.getStringList('user') ?? null);
    setState(() {
      uid = _uid[0];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection('/users/$uid/club').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                List<DocumentSnapshot> clubs = snapshot.data.docs;
                // print(clubs[index]['name']);
                return ClubList(clist: clubs, index: index);
              });
        } else if (snapshot.hasError) {
          return Container(
            height: 200.0,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        } else {
          return Container(
            height: 200.0,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        }
      },
    );
  }
}
