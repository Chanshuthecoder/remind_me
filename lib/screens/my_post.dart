import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:remind_me/screens/feed_detail.dart';

class MyPost extends StatefulWidget {
  final String club;
  MyPost({this.club});
  @override
  _MyPostState createState() => _MyPostState(club);
}

class _MyPostState extends State<MyPost> {
  String club;
  _MyPostState(this.club);
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Posts"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('/feed')
            .where('posted_by', isEqualTo: club)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 200.0,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
              ),
            );
          } else {
            return Column(
              children:
                  snapshot.data.docs.map<Widget>((DocumentSnapshot document) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedDetail(task: document),
                      ),
                    );
                  },
                  leading: Icon(Icons.supervised_user_circle),
                  trailing: InkWell(
                    onTap: () {
                      db.collection('/feed').doc(document.id).delete();
                    },
                    child: Text(
                      "Remove",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  title: Text(
                    document['feed'],
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                  subtitle: Text(document['date']),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
