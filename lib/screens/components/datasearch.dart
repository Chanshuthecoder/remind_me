import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/screens/search_result.dart';
// import 'package:remind_me/util/subscribe.dart';

class DataSearch extends SearchDelegate<String> {
  final String uid;
  DataSearch({this.uid});

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('/users')
          .where('tags', arrayContains: query)
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
                      builder: (context) => SearchResult(
                        name: document['name'],
                        email: document['email'],
                        clubId: document.id,
                        uid: uid,
                      ),
                    ),
                  );
                },
                leading: Icon(Icons.supervised_user_circle),
                title: Text(
                  document['name'],
                  style: TextStyle(color: Colors.lightBlue),
                ),
                subtitle: Text(document['email']),
              );
            }).toList(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestion
    if (query.isNotEmpty) {
      print("user id will be printed below .....=+++++====++++++");
      print(uid);
      print("user id will be printed above .....=+++++====++++++");
      return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('/users')
            .where('tags', arrayContains: query)
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
                          builder: (context) => SearchResult(
                            name: document['name'],
                            email: document['email'],
                            clubId: document.id,
                            uid: uid,
                          ),
                        ));
                  },
                  leading: Icon(Icons.supervised_user_circle),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_circle_up_rounded),
                    onPressed: () {
                      query = document['name'];
                    },
                  ),
                  title: Text(
                    document['name'],
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                  subtitle: Text(document['email']),
                );
              }).toList(),
            );
          }
        },
      );
    }

    // final suggestionList = query.isEmpty ? _recentClubs :
    else {
      return Container();
    }
  }
}
