import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/screens/components/clublist.dart';

class Feed extends StatefulWidget {
  final String uid;
  Feed({this.uid});
  @override
  _FeedState createState() => _FeedState(uid);
}

class _FeedState extends State<Feed> {
  String uid;
  _FeedState(this.uid);
  final db = FirebaseFirestore.instance;

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
