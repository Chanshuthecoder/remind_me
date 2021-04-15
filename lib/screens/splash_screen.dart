import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remind_me/screens/todo_screen.dart';
import 'package:remind_me/util/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Some variables
  User userData = User();
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), _loadCredentials);
  }

//Loading counter value on start
  _loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = (prefs.getStringList('user') ?? null);

    if (user != null) {
      userData.uId = user[0];
      userData.uType = user[1];
      userData.uName = user[2];
      userData.uEmail = user[3];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TodoScreen(userData: userData),
        ),
      );
      print(user);
      // Navigator.pushReplacementNamed(context, '/todo');
    } else {
      print(user);
      Navigator.pushReplacementNamed(context, '/register');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
          child: Image.asset(
            'assets/images/splash_icon.jpg',
            height: 180.0,
            width: 180.0,
          ),
        ),
      ),
    );
  }
}
