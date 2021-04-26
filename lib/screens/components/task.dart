import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/screens/task_detail.dart';

class Task extends StatefulWidget {
  final String uid;
  Task({this.uid});
  @override
  _TaskState createState() => _TaskState(uid);
}

class _TaskState extends State<Task> {
  String uid;
  _TaskState(this.uid);
  final db = FirebaseFirestore.instance;
  // String uid = 'nn2l8mO5RcUsIicXZIQjwjmtGiQ2';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection('/users/$uid/task/').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              return Card(
                elevation: 5.0,
                child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetail(task: ds),
                        ),
                      );
                    },
                    title: Text(
                      ds['title'],
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(ds['date'] + ' ' + ds['startAt']),
                    leading: Icon(
                      Icons.schedule,
                      size: 36.0,
                      color: Colors.blueAccent,
                    ),
                    trailing: InkWell(
                      child: Icon(
                        Icons.delete_forever_rounded,
                        size: 36.0,
                        color: Colors.redAccent,
                      ),
                      onTap: () {
                        // print('unsubscribed');
                        db.collection('/users/$uid/task').doc(ds.id).delete();
                      },
                    )),
              );
            },
          );
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
