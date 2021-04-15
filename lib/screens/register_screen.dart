import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/util/auth.dart';
import 'package:remind_me/util/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  User user = User();
  String _registerAs = "Student";
  final db = FirebaseFirestore.instance;
  _setCredentials(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList("user", [userId, user.uType, user.uName, user.uEmail]);
    prefs.setBool("session", true);
  }

  void validate() {
    if (formkey.currentState.validate()) {
      signUp(user.uEmail.trim(), user.uPassword.trim()).then((userId) {
        if (userId != "error") {
          user.uType = _registerAs;
          _setCredentials(userId);
          db.collection('/users').doc('/$userId').set({
            'name': user.uName,
            'email': user.uEmail,
            'password': user.uPassword,
            'type': user.uType,
            'id': userId
          }).whenComplete(() {
            Navigator.pushReplacementNamed(context, "/todo");
          });
        }
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.dangerous,
                color: Colors.red,
                size: 28,
              ),
              title: Text(":) Could not Validate"),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        SizedBox(
          height: 35,
        ),
        Center(
          child: Image.asset(
            'assets/images/splash_icon.jpg',
            height: 180.0,
            width: 180.0,
          ),
        ),
        Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        value: "Student",
                        groupValue: _registerAs,
                        onChanged: (val) {
                          _registerAs = val;
                          setState(() {});
                        }),
                    Text("Student"),
                    Radio(
                        value: "Organisation",
                        groupValue: _registerAs,
                        onChanged: (val) {
                          _registerAs = val;
                          setState(() {});
                        }),
                    Text("Organization"),
                  ],
                ),
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    hintText: "Username",
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Required";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) => user.uName = value,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      hintText: "Email",
                      icon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      } else if (value.length < 8) {
                        return "Should be atleast 8 character";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => user.uEmail = value,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      hintText: "Password",
                      icon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      } else if (value.length < 8) {
                        return "Should be atleast 8 character";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) => user.uPassword = value,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: FlatButton(
                    minWidth: 250,
                    height: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: validate,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.orange,
                    textColor: Colors.white,
                    splashColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    "Already have an account? : Sign In",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
// ---------------------------------------------------------
