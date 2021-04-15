import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/util/subscribe.dart';

class DataSearch extends SearchDelegate<String> {
  //variables
  bool _subscibed = false;
  // List<String> _clubs;
  List<String> _recentClubs = [
    'Coding Club',
    'Electronics Club',
    'Ai Club',
    'Aeromodelling Club'
  ];
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
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestion
    if (query.isNotEmpty) {
      return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('/users')
            .where('name', isEqualTo: query)
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
                  leading: Icon(Icons.supervised_user_circle),
                  trailing: InkWell(
                    onTap: () {
                      subscribe(document['name']);
                    },
                    child: Text(
                      _subscibed ? "Subscribed" : "Subscribe",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  title: Text(
                    document['name'],
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                  subtitle: Text(document['type']),
                );
              }).toList(),
            );
          }
        },
      );
    }

    // final suggestionList = query.isEmpty ? _recentClubs :
    else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            autofocus: true,
            leading: Icon(Icons.supervised_user_circle),
            trailing: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                _recentClubs.removeAt(index);
              },
            ),
            title: Text(_recentClubs[index]),
          );
        },
        itemCount: _recentClubs.length,
      );
    }
  }
}
