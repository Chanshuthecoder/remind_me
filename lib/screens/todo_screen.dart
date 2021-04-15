import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remind_me/screens/add_feed.dart';
import 'package:remind_me/screens/add_task.dart';
import 'package:remind_me/screens/components/task.dart';
import 'package:remind_me/screens/main_drawer.dart';
import 'package:remind_me/util/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'components/club.dart';
import 'components/datasearch.dart';
import 'components/feed.dart';
import 'components/task.dart';

class TodoScreen extends StatefulWidget {
  final User userData;
  TodoScreen({this.userData});
  @override
  _TodoScreenState createState() => _TodoScreenState(userData);
}

class _TodoScreenState extends State<TodoScreen>
    with SingleTickerProviderStateMixin {
  User userData;
  _TodoScreenState(this.userData);
  TabController _tabController;
  //variables
  int count = 0;
  int tabbarindex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // _loadCredential();
    downloadURLExample(userData.uId);
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      switch (_tabController.index) {
        case 2:
          setState(() {
            tabbarindex = 2;
          });
          break;
        case 1:
          setState(() {
            tabbarindex = 1;
          });
          break;
        case 0:
          setState(() {
            tabbarindex = 0;
          });
          break;
        default:
          tabbarindex = 0;
      }
    });
  }

  Future<void> downloadURLExample(String userId) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('images/$userId/profile.jpg')
        .getDownloadURL();
    userData.uProfilePic = downloadURL;
  }

  Widget _getFAB() {
    if (tabbarindex == 0) {
      return FloatingActionButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(userData: userData),
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      );
    } else if (tabbarindex == 1 && userData.uType == "Organisation") {
      return FloatingActionButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFeed(userData: userData),
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      );
    } else {
      return Container();
    }
  }

//------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
        bottom: TabBar(
          tabs: [
            Text("MyTask"),
            Text("Feed"),
            Text("Club"),
          ],
          labelPadding: EdgeInsets.all(10.0),
          labelColor: Colors.white,
          labelStyle: TextStyle(
            fontSize: 14.0,
          ),
          unselectedLabelColor: Colors.white60,
          controller: _tabController,
        ),
      ),
      floatingActionButton: _getFAB(),
      drawer: MainDrawer(userData: userData),
      body: TabBarView(
        children: [
          Task(uid: userData.uId),
          Feed(),
          Club(),
        ],
        controller: _tabController,
      ),
    );
  }
}
