import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Club extends StatefulWidget {
  @override
  _ClubState createState() => _ClubState();
}

class _ClubState extends State<Club> {
  final db = FirebaseFirestore.instance;
  String uid = 'nn2l8mO5RcUsIicXZIQjwjmtGiQ2';
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
                    subtitle: Text("Organisation"),
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
