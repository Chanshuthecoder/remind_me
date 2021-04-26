import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Club extends StatefulWidget {
  final String uid;
  Club({this.uid});
  @override
  _ClubState createState() => _ClubState(uid);
}

class _ClubState extends State<Club> {
  String uid;
  _ClubState(this.uid);
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
              DocumentSnapshot ds = snapshot.data.docs[index];
              return Card(
                elevation: 5.0,
                child: ListTile(
                    title: Text(
                      ds['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(ds['email']),
                    leading: Icon(
                      Icons.group,
                      color: Colors.orange,
                      size: 38,
                    ),
                    trailing: InkWell(
                      autofocus: true,
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onTap: () {
                        print('unsubscribed');
                        db.collection('/users/$uid/club').doc(ds.id).delete();
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
