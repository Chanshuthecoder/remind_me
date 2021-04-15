import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/util/note.dart';
import 'package:remind_me/util/user.dart';

class AddFeed extends StatefulWidget {
  final User userData;
  AddFeed({this.userData});

  @override
  _AddFeedState createState() => _AddFeedState(userData);
}

class _AddFeedState extends State<AddFeed> {
  //Variables
  User userData;
  _AddFeedState(this.userData);
  final db = FirebaseFirestore.instance;
  String _selectedParam = "Weekly";
  Note feed = Note("", "", 1);
  DateTime pickedDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post a Feed",
        ),
        actions: [
          FlatButton(
            child: Text(
              "Post",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              _save(userData.uName, userData.uId);
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (val) {
                feed.title = val;
              },
              autocorrect: true,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Title",
                icon: Icon(Icons.title),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (val) {
                feed.description = val;
              },
              autocorrect: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "description",
                icon: Icon(Icons.description_rounded),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Date          : ",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  child: Text(
                    " ${pickedDate.day}/${pickedDate.month}/${pickedDate.year}",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  onTap: () {
                    _pickDate();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "StartAt      : ",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  child: Text(
                    "${time.hour}:${time.minute}",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  onTap: () {
                    _pickTime();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "EndAt        : ",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  child: Text(
                    "${time.hour}:${time.minute}",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  onTap: () {
                    _pickTime();
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton(
                value: _selectedParam,
                items: [
                  DropdownMenuItem(
                    child: Text("Daily"),
                    value: "Daily",
                  ),
                  DropdownMenuItem(
                    child: Text("Weekly"),
                    value: "Weekly",
                  ),
                ],
                onChanged: (_val) {
                  setState(() {
                    _selectedParam = _val;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void _save(String clubName, String uid) async {
    Navigator.pop(context);
    feed.priority = 1;
    feed.date = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    db.collection('/feed').add({
      'feed': feed.title,
      'description': feed.description,
      'date': feed.date,
      'StartAt': "${time.hour}:${time.minute} ${time.period}",
      'EndAt': "${time.hour}:${time.minute} ${time.period}",
      'posted_by': clubName,
    });
  }

  Future<void> _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (t != null) {
      setState(() {
        time = t;
      });
    }
  }
}
