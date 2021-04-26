import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/screens/register_screen.dart';
import 'package:remind_me/screens/todo_screen.dart';
import 'package:remind_me/screens/login_screen.dart';
import 'package:remind_me/util/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/todo": (context) => TodoScreen()
      },
      title: "Remind Me",
      theme: ThemeData(primarySwatch: Colors.orange),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserDetails usr = UserDetails();
  String uid;
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          uid = null;
        });
      } else {
        print('User is signed in!');
        uid = user.uid;
        FirebaseFirestore.instance
            .collection('/users')
            .doc('/${user.uid}')
            .get()
            .then((document) {
          setState(() {
            usr.uName = document.data()['name'];
            usr.uType = document.data()['type'];
            usr.uEmail = document.data()['email'];
            usr.uPassword = document.data()['password'];
            usr.uId = document.data()['id'];
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return uid != null ? TodoScreen(userData: usr) : LoginScreen();
  }
}
