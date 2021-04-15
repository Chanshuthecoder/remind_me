import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/screens/feed_detail.dart';

class ClubList extends StatelessWidget {
  final List<DocumentSnapshot> clist;

  final int index;
  ClubList({this.clist, this.index});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('/feed')
          .where('posted_by', isEqualTo: clist[index]['name'].toString())
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
              return Card(
                elevation: 5,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedDetail(task: document),
                      ),
                    );
                  },
                  leading: Icon(
                    Icons.android,
                    color: Colors.green,
                    size: 38,
                  ),
                  title: Text(
                    document['feed'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(document['posted_by']),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
