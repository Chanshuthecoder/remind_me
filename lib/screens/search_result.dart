import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  final String name;
  final String email;
  final String clubId;
  final String uid;
  SearchResult({this.name, this.email, this.clubId, this.uid});
  @override
  _SearchResultState createState() =>
      _SearchResultState(name, email, clubId, uid);
}

class _SearchResultState extends State<SearchResult> {
  String name;
  String email;
  String clubId;
  String uid;
  _SearchResultState(this.name, this.email, this.clubId, this.uid);
  bool isSubscribed = false;
  @override
  void initState() {
    super.initState();
    var myclub = FirebaseFirestore.instance
        .collection('/users/$uid/club')
        .doc(clubId)
        .get();
    myclub.then((val) {
      print(val.exists);
      print(uid);
      setState(() {
        isSubscribed = val.exists;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Club"),
        centerTitle: true,
      ),
      body: isSubscribed
          ? Card(
              elevation: 5,
              child: ListTile(
                title: Text("$name"),
                subtitle: Text("$email"),
                leading: Icon(Icons.group),
                trailing: InkWell(
                  child: Text(
                    "Subscribed",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('/users/$uid/club')
                        .doc(clubId)
                        .delete();
                    setState(() {
                      isSubscribed = !isSubscribed;
                    });
                  },
                ),
              ),
            )
          : Card(
              elevation: 5,
              child: ListTile(
                title: Text("$name"),
                subtitle: Text("$email"),
                leading: Icon(Icons.group),
                trailing: InkWell(
                  child: Text(
                    "Subscribe",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('/users/$uid/club')
                        .doc(clubId)
                        .set({
                      'name': name,
                      'email': email,
                    }).whenComplete(() {
                      setState(() {
                        isSubscribed = !isSubscribed;
                      });
                    });
                  },
                ),
              ),
            ),
    );
  }
}
