import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedDetail extends StatelessWidget {
  final DocumentSnapshot task;
  FeedDetail({this.task});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Details"),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25, left: 25),
            child: Container(
              width: double.infinity,
              height: 40,
              child: Text(
                task['feed'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, left: 25),
            child: Container(
              width: double.infinity,
              height: 60,
              child: Text(
                task["date"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 25),
            child: Container(
              width: double.infinity,
              height: 180,
              child: Text(
                "Description:\n" + task["description"],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 25),
            child: Container(
              width: double.infinity,
              height: 100,
              child: Text(
                "Time:\n" + task["StartAt"] + 'to' + task["EndAt"],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 25),
            child: Container(
              width: double.infinity,
              height: 100,
              child: Text(
                "Posted By:\n" + task["posted_by"],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
